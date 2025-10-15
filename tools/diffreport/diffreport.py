
"""
    diffreport - Generate a Diff Report for C64OS Code Changes
    ==========================================================

    Summary
    -------

    Note
    ----
    Proudly made with @GR0K

    Meta
    ----
    Author:         @GR0K
    Slop Checker:   paul@spocker.net
    Github:         https://github.com/OpCoders-Inc/c64os-dev

    History
    -------

"""



import os
import difflib
from datetime import datetime
import html
import argparse


def compare_directories(dir1_path, dir2_path, output_dir="report", title="C64OS API Changes", sub_title="Changes since last version"):
    """
    Recursively compare files in two directories, ignoring blank lines for differences,
    generating a main report with closed accordion sections, an all-files page listing
    every file with its status and change count for modified files, and separate Bootstrap-styled
    HTML pages for added, removed, unchanged, and modified files with two-column diff tables.
    Changed lines are highlighted in yellow, added in green, removed in red, no navigation columns.
    Diff table shows new file on left, old file on right. Within changed lines, differing text
    is highlighted with a darker hue, bold, and darker yellow background. Added and deleted text
    have darker green and red backgrounds, respectively, and are bold. Unchanged lines alternate
    with a subtle background, with the old file column slightly darker. Summary page uses
    a 4-column grid for file lists and includes a detailed statistics table with total lines
    added/removed, average change count, and largest file by size. All-files page lists every
    file with status, change count, and links, with toggleable buttons to show/hide rows by
    status, with states persisted using localStorage. The all-files page defaults to showing
    only Modified files on first load.
    
    Args:
        dir1_path (str): Path to the first (old) directory.
        dir2_path (str): Path to the second (new) directory.
        output_dir (str): Directory to save the reports (default: report).
        title (str): Main title for the HTML report (default: C64OS API Changes).
        sub_title (str): Subtitle for the HTML reports (default: Changes since last version).
    """
    # Ensure directories exist
    if not (os.path.isdir(dir1_path) and os.path.isdir(dir2_path)):
        print("Error: One or both directories do not exist.")
        return

    # Create output directory and files subdirectory
    os.makedirs(output_dir, exist_ok=True)
    diff_dir = os.path.join(output_dir, "files")
    os.makedirs(diff_dir, exist_ok=True)

    # Get all files in both directories recursively
    def get_all_files(directory):
        file_map = {}
        for root, _, files in os.walk(directory):
            for file_name in files:
                relative_path = os.path.relpath(os.path.join(root, file_name), directory)
                file_map[relative_path] = os.path.join(root, file_name)
        return file_map

    dir1_files = get_all_files(dir1_path)
    dir2_files = get_all_files(dir2_path)

    # Categorize files
    all_relative_paths = set(dir1_files.keys()).union(dir2_files.keys())
    added_files = set(dir2_files.keys()) - set(dir1_files.keys())
    removed_files = set(dir1_files.keys()) - set(dir2_files.keys())
    common_files = set(dir1_files.keys()).intersection(dir2_files.keys())
    modified_files = []
    unchanged_files = []
    change_counts = {}  # Store change counts for modified files
    total_lines_added = 0  # Track total lines added across modified files
    total_lines_removed = 0  # Track total lines removed across modified files
    largest_file = {'path': 'N/A', 'size': -1, 'status': 'N/A'}  # Track largest file by size

    # Compare common files, ignoring blank lines, and collect statistics
    for relative_path in common_files:
        file1_path = dir1_files[relative_path]
        file2_path = dir2_files[relative_path]

        # Update largest file
        file_size = max(os.path.getsize(file1_path), os.path.getsize(file2_path))
        if file_size > largest_file['size']:
            largest_file['path'] = relative_path
            largest_file['size'] = file_size
            largest_file['status'] = 'Unchanged'  # Default, updated below if modified

        try:
            with open(file1_path, 'r', encoding='utf-8', errors='ignore') as f1, \
                 open(file2_path, 'r', encoding='utf-8', errors='ignore') as f2:
                # Read lines and filter out blank lines for comparison
                lines1 = [line.rstrip('\n') for line in f1.readlines() if line.strip()]
                lines2 = [line.rstrip('\n') for line in f2.readlines() if line.strip()]

            # Compare non-blank lines to determine if file is modified
            if lines1 != lines2:
                modified_files.append(relative_path)
                largest_file['status'] = 'Modified' if relative_path == largest_file['path'] else largest_file['status']
                # Count changes and lines added/removed
                matcher = difflib.SequenceMatcher(None, lines1, lines2)
                change_count = 0
                for tag, i1, i2, j1, j2 in matcher.get_opcodes():
                    if tag == 'replace':
                        change_count += max(i2 - i1, j2 - j1)
                        total_lines_added += j2 - j1
                        total_lines_removed += i2 - i1
                    elif tag == 'delete':
                        change_count += i2 - i1
                        total_lines_removed += i2 - i1
                    elif tag == 'insert':
                        change_count += j2 - j1
                        total_lines_added += j2 - j1
                change_counts[relative_path] = change_count
            else:
                unchanged_files.append(relative_path)
        except (UnicodeDecodeError, IOError):
            # Treat binary files or unreadable files as modified if their sizes differ
            if os.path.getsize(file1_path) != os.path.getsize(file2_path):
                modified_files.append(relative_path)
                largest_file['status'] = 'Modified' if relative_path == largest_file['path'] else largest_file['status']
                change_counts[relative_path] = 0  # Binary files have no line-based change count
            else:
                unchanged_files.append(relative_path)

    # Check added and removed files for largest file
    for relative_path in added_files:
        file_size = os.path.getsize(dir2_files[relative_path])
        if file_size > largest_file['size']:
            largest_file['path'] = relative_path
            largest_file['size'] = file_size
            largest_file['status'] = 'Added'

    for relative_path in removed_files:
        file_size = os.path.getsize(dir1_files[relative_path])
        if file_size > largest_file['size']:
            largest_file['path'] = relative_path
            largest_file['size'] = file_size
            largest_file['status'] = 'Removed'

    # Calculate average change count
    avg_change_count = (sum(change_counts.values()) / len(modified_files)) if modified_files else 0
    avg_change_count = f"{avg_change_count:.2f}" if modified_files else "N/A"

    # Format largest file size in human-readable format
    largest_file_size = largest_file['size']
    if largest_file_size >= 1024 * 1024:
        largest_file_size = f"{largest_file_size / (1024 * 1024):.2f} MB"
    elif largest_file_size >= 1024:
        largest_file_size = f"{largest_file_size / 1024:.2f} KB"
    else:
        largest_file_size = f"{largest_file_size} bytes"

    # Initialize timestamp before any report generation
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Common CSS for individual HTML pages and all-files page
    common_css = """
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 0; padding: 20px; background-color: #f8f9fa; }
        .container { max-width: 1200px; margin: 0 auto; }
        .card { box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-radius: 8px; }
        h1 { color: #343a40; font-size: 1.75rem; }
        pre { background: #ffffff; padding: 15px; border-radius: 5px; border: 1px solid #dee2e6; font-size: 14px; overflow-x: auto; }
        table.diff { font-family: monospace; width: 100%; border-collapse: collapse; }
        .diff_header { background-color: #e9ecef; font-weight: bold; padding: 8px; text-align: center; }
        .diff_add { background-color: #d4edda; color: #1a3c34; } /* Green for added lines */
        .diff_sub { background-color: #f8d7da; color: #6b1a1c; } /* Red for removed lines */
        .diff_chg { background-color: #fff3cd; color: #5a3e03; } /* Yellow for changed lines */
        .diff_text { color: #1a1200; font-weight: bold; background-color: #ffda73; } /* Darker hue, bold, darker yellow for changed text */
        .diff_text_add { color: #1a3c34; background-color: #a3d6b0; font-weight: bold; } /* Darker green for added text, bold */
        .diff_text_sub { color: #6b1a1c; background-color: #f1a6ac; font-weight: bold; } /* Darker red for deleted text, bold */
        .diff_unchanged_alt { background-color: #f5f6f5; } /* Subtle background for alternating unchanged lines (new file) */
        .diff_unchanged_alt_old { background-color: #eceeed; } /* Slightly darker background for alternating unchanged lines (old file) */
        .added_content { background-color: #d4edda; padding: 15px; border-radius: 5px; }
        .removed_content { background-color: #f8d7da; padding: 15px; border-radius: 5px; }
        .unchanged_content { background-color: #ffffff; padding: 15px; border-radius: 5px; }
        .btn-back, .btn-all-files { display: inline-block; padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; margin-bottom: 20px; margin-right: 10px; }
        .btn-back:hover, .btn-all-files:hover { background-color: #0056b3; }
        .legend-card { background-color: #ffffff; padding: 10px; margin-bottom: 20px; }
        td { padding: 8px; vertical-align: top; }
        .file-item { border: 1px solid #dee2e6; padding: 8px; margin-bottom: 8px; background-color: #ffffff; border-radius: 4px; }
        .file-item a { color: #007bff; text-decoration: none; display: block; }
        .file-item a:hover { color: #0056b3; background-color: #f1f3f5; }
        .status-added { background-color: #d4edda; color: #1a3c34; font-weight: bold; padding: 2px 8px; border-radius: 4px; }
        .status-removed { background-color: #f8d7da; color: #6b1a1c; font-weight: bold; padding: 2px 8px; border-radius: 4px; }
        .status-modified { background-color: #fff3cd; color: #5a3e03; font-weight: bold; padding: 2px 8px; border-radius: 4px; }
        .status-unchanged { background-color: #f5f6f5; color: #343a40; font-weight: bold; padding: 2px 8px; border-radius: 4px; }
        .table-all-files { font-size: 14px; }
        .filter-controls { margin-bottom: 20px; }
        .filter-controls .btn { margin-right: 10px; font-size: 14px; padding: 6px 12px; }
        .filter-controls .btn.active { background-color: #007bff; color: white; }
        .filter-controls .btn:not(.active) { background-color: #ffffff; color: #007bff; border: 1px solid #007bff; }
    """

    # Function to highlight differing text within changed lines
    def highlight_diff_text(old_line, new_line):
        matcher = difflib.SequenceMatcher(None, old_line, new_line)
        old_output = []
        new_output = []
        for tag, i1, i2, j1, j2 in matcher.get_opcodes():
            old_text = old_line[i1:i2]
            new_text = new_line[j1:j2]
            if tag == 'equal':
                old_output.append(html.escape(old_text))
                new_output.append(html.escape(new_text))
            elif tag == 'delete':
                old_output.append(f'<span class="diff_text_sub">{html.escape(old_text)}</span>')
                new_output.append('')
            elif tag == 'insert':
                old_output.append('')
                new_output.append(f'<span class="diff_text_add">{html.escape(new_text)}</span>')
            elif tag == 'replace':
                old_output.append(f'<span class="diff_text_sub">{html.escape(old_text)}</span>')
                new_output.append(f'<span class="diff_text_add">{html.escape(new_text)}</span>')
        old_result = ''.join(old_output)
        new_result = ''.join(new_output)
        # Debug logging to terminal
        print(f"DEBUG: Changed old line: {old_result}")
        print(f"DEBUG: Changed new line: {new_result}")
        return old_result, new_result

    # Generate individual HTML pages for all files
    html_diff_paths = {}

    # Modified files
    for relative_path in modified_files:
        file1_path = dir1_files[relative_path]
        file2_path = dir2_files[relative_path]
        try:
            with open(file1_path, 'r', encoding='utf-8', errors='ignore') as f1, \
                 open(file2_path, 'r', encoding='utf-8', errors='ignore') as f2:
                # Read all lines, including blank lines, for display
                lines1 = [line.rstrip('\n') for line in f1.readlines()]
                lines2 = [line.rstrip('\n') for line in f2.readlines()]
                # Use SequenceMatcher for precise line alignment
                matcher = difflib.SequenceMatcher(None, lines1, lines2)
                old_lines = []
                new_lines = []
                unchanged_count = 0  # Track unchanged lines for alternating background
                
                for tag, i1, i2, j1, j2 in matcher.get_opcodes():
                    if tag == 'equal':
                        # Unchanged lines
                        for i in range(i1, i2):
                            new_class = 'diff_unchanged_alt' if unchanged_count % 2 == 1 else ''
                            old_class = 'diff_unchanged_alt_old' if unchanged_count % 2 == 1 else ''
                            old_lines.append((html.escape(lines1[i]), old_class))
                            new_lines.append((html.escape(lines2[j1 + (i - i1)]), new_class))
                            unchanged_count += 1
                            print(f"DEBUG: Unchanged line (new_alt={new_class}, old_alt={old_class}): {html.escape(lines1[i])}")
                    elif tag == 'replace':
                        # Changed lines (paired modifications)
                        for k in range(max(i2 - i1, j2 - j1)):
                            old_content = lines1[i1 + k] if i1 + k < i2 else ''
                            new_content = lines2[j1 + k] if j1 + k < j2 else ''
                            if old_content.strip() and new_content.strip():
                                # Both lines are non-blank, treat as change with word-level diff
                                old_highlighted, new_highlighted = highlight_diff_text(old_content, new_content)
                                old_lines.append((old_highlighted, 'diff_chg'))
                                new_lines.append((new_highlighted, 'diff_chg'))
                            else:
                                # Handle as separate deletion/addition if one is blank
                                if old_content:
                                    old_highlighted = f'<span class="diff_text_sub">{html.escape(old_content)}</span>'
                                    print(f"DEBUG: Deleted line: {old_highlighted}")
                                    old_lines.append((old_highlighted, 'diff_sub'))
                                    new_lines.append(('', ''))
                                if new_content:
                                    new_highlighted = f'<span class="diff_text_add">{html.escape(new_content)}</span>'
                                    print(f"DEBUG: Added line: {new_highlighted}")
                                    old_lines.append(('', ''))
                                    new_lines.append((new_highlighted, 'diff_add'))
                    elif tag == 'delete':
                        # Pure deleted lines
                        for i in range(i1, i2):
                            old_highlighted = f'<span class="diff_text_sub">{html.escape(lines1[i])}</span>'
                            print(f"DEBUG: Deleted line: {old_highlighted}")
                            old_lines.append((old_highlighted, 'diff_sub'))
                            new_lines.append(('', ''))
                    elif tag == 'insert':
                        # Pure added lines
                        for j in range(j1, j2):
                            new_highlighted = f'<span class="diff_text_add">{html.escape(lines2[j])}</span>'
                            print(f"DEBUG: Added line: {new_highlighted}")
                            old_lines.append(('', ''))
                            new_lines.append((new_highlighted, 'diff_add'))

                # Create HTML table (new file on left, old file on right)
                diff_table = '<table class="diff">\n'
                diff_table += '<tr><td class="diff_header">New: {0}</td><td class="diff_header">Old: {0}</td></tr>\n'.format(html.escape(relative_path))
                for (old_line, old_class), (new_line, new_class) in zip(old_lines, new_lines):
                    diff_table += f'<tr><td class="{new_class}">{new_line}</td><td class="{old_class}">{old_line}</td></tr>\n'
                diff_table += '</table>'

                # Build full HTML page with debug script
                diff_html = f"""<html>
<head>
    <title>Diff for {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Difference for {html.escape(relative_path)}</h1>
            <div class="legend-card">
                <p><strong>Legend:</strong></p>
                <p><span style="background-color: #fff3cd; color: #5a3e03; padding: 2px 5px;">Changed lines</span> are yellow with darker yellow-brown text; <span style="background-color: #ffda73; color: #1a1200; font-weight: bold;">changed text</span> within lines is darker, bold, with a darker yellow background.</p>
                <p><span style="background-color: #d4edda; color: #1a3c34; padding: 2px 5px;">Added lines</span> are green with darker green text; <span style="background-color: #a3d6b0; color: #1a3c34; font-weight: bold;">added text</span> is bold with a darker green background (new file).</p>
                <p><span style="background-color: #f8d7da; color: #6b1a1c; padding: 2px 5px;">Removed lines</span> are red with darker red text; <span style="background-color: #f1a6ac; color: #6b1a1c; font-weight: bold;">removed text</span> is bold with a darker red background (old file).</p>
                <p>Unchanged lines have no background color or alternate with a subtle gray background (<span style="background-color: #f5f6f5; padding: 2px 5px;">new file</span>, <span style="background-color: #eceeed; padding: 2px 5px;">old file</span>).</p>
            </div>
            <p>Side-by-side comparison of changes (new file on left, old file on right).</p>
            {diff_table}
        </div>
    </div>
</body>
</html>"""
                # Save individual diff HTML
                safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
                diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
                with open(diff_html_path, 'w', encoding='utf-8') as f:
                    f.write(diff_html)
                html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)
        except (UnicodeDecodeError, IOError):
            # Binary file HTML
            file_size1 = os.path.getsize(file1_path)
            file_size2 = os.path.getsize(file2_path)
            diff_html = f"""<html>
<head>
    <title>Diff for {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Difference for {html.escape(relative_path)}</h1>
            <p>Binary or unreadable file. Files differ.</p>
            <p>Old file size: {file_size1} bytes</p>
            <p>New file size: {file_size2} bytes</p>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)

    # Added files
    for relative_path in added_files:
        file_path = dir2_files[relative_path]
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = html.escape(f.read())
            diff_html = f"""<html>
<head>
    <title>Added File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Added File: {html.escape(relative_path)}</h1>
            <p>This file was added in the new directory.</p>
            <pre class="added_content">{content}</pre>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)
        except (UnicodeDecodeError, IOError):
            file_size = os.path.getsize(file_path)
            diff_html = f"""<html>
<head>
    <title>Added File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Added File: {html.escape(relative_path)}</h1>
            <p>Binary or unreadable file. This file was added in the new directory.</p>
            <p>File size: {file_size} bytes</p>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)

    # Removed files
    for relative_path in removed_files:
        file_path = dir1_files[relative_path]
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = html.escape(f.read())
            diff_html = f"""<html>
<head>
    <title>Removed File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Removed File: {html.escape(relative_path)}</h1>
            <p>This file was removed in the new directory.</p>
            <pre class="removed_content">{content}</pre>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)
        except (UnicodeDecodeError, IOError):
            file_size = os.path.getsize(file_path)
            diff_html = f"""<html>
<head>
    <title>Removed File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Removed File: {html.escape(relative_path)}</h1>
            <p>Binary or unreadable file. This file was removed in the new directory.</p>
            <p>File size: {file_size} bytes</p>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)

    # Unchanged files
    for relative_path in unchanged_files:
        file_path = dir2_files[relative_path]
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = html.escape(f.read())
            diff_html = f"""<html>
<head>
    <title>Unchanged File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Unchanged File: {html.escape(relative_path)}</h1>
            <p>This file is identical in both directories.</p>
            <pre class="unchanged_content">{content}</pre>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)
        except (UnicodeDecodeError, IOError):
            file_size = os.path.getsize(file_path)
            diff_html = f"""<html>
<head>
    <title>Unchanged File: {html.escape(relative_path)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="../index.html" class="btn-back">Back to Main Report</a>
        <a href="../files.html" class="btn-back">View All Files</a>
        <div class="card p-4">
            <h1>Unchanged File: {html.escape(relative_path)}</h1>
            <p>Binary or unreadable file. This file is identical in both directories (same size).</p>
            <p>File size: {file_size} bytes</p>
        </div>
    </div>
</body>
</html>"""
            safe_filename = relative_path.replace(os.sep, '_').replace(' ', '_')
            diff_html_path = os.path.join(diff_dir, f"diff_{safe_filename}.html")
            with open(diff_html_path, 'w', encoding='utf-8') as f:
                f.write(diff_html)
            html_diff_paths[relative_path] = os.path.relpath(diff_html_path, output_dir)

    # Generate all-files HTML page with toggleable status filter buttons and change count
    all_files_html = f"""<html>
<head>
    <title>All Files Comparison</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>{common_css}</style>
</head>
<body>
    <div class="container">
        <a href="index.html" class="btn-back">Back to Main Report</a>
        <div class="card p-4">
            <h1>All Files Comparison</h1>
            <p><strong>{html.escape(sub_title)}</strong></p>
            <p>Generated: {timestamp}</p>
            <div class="legend-card">
                <p><strong>Legend:</strong></p>
                <p><span class="status-added">Added</span>: Files present only in the new directory.</p>
                <p><span class="status-removed">Removed</span>: Files present only in the old directory.</p>
                <p><span class="status-modified">Modified</span>: Files present in both directories with differences (change count shown).</p>
                <p><span class="status-unchanged">Unchanged</span>: Files identical in both directories.</p>
            </div>
            <div class="filter-controls">
                <button class="btn btn-primary active" id="filter-added" data-active="true">Show Added</button>
                <button class="btn btn-primary active" id="filter-removed" data-active="true">Show Removed</button>
                <button class="btn btn-primary active" id="filter-modified" data-active="true">Show Modified</button>
                <button class="btn btn-primary active" id="filter-unchanged" data-active="true">Show Unchanged</button>
            </div>
            <table class="table table-bordered table-all-files">
                <thead>
                    <tr>
                        <th>File Path</th>
                        <th>Status</th>
                        <th>Changes</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
"""
    # Create sorted list of all files with their status and change count
    all_files = []
    for f in added_files:
        all_files.append((f, 'Added', html_diff_paths[f], '-'))
    for f in removed_files:
        all_files.append((f, 'Removed', html_diff_paths[f], '-'))
    for f in modified_files:
        change_count = change_counts.get(f, 0)
        all_files.append((f, 'Modified', html_diff_paths[f], str(change_count)))
    for f in unchanged_files:
        all_files.append((f, 'Unchanged', html_diff_paths[f], '-'))
    all_files.sort(key=lambda x: x[0])  # Sort by file path

    for file_path, status, link, change_count in all_files:
        status_class = {
            'Added': 'status-added',
            'Removed': 'status-removed',
            'Modified': 'status-modified',
            'Unchanged': 'status-unchanged'
        }[status]
        row_class = f"row-{status_class}"  # Class for filtering rows
        all_files_html += f'<tr class="{row_class}"><td>{html.escape(file_path)}</td><td><span class="{status_class}">{status}</span></td><td>{change_count}</td><td><a href="{link}">View Details</a></td></tr>\n'

    all_files_html += """
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Debug logging
        console.log('DEBUG: Checking rows in all-files table: ' + document.querySelectorAll('.table-all-files tbody tr').length);
        console.log('DEBUG: Checking status-added: ' + document.querySelectorAll('.status-added').length);
        console.log('DEBUG: Checking status-removed: ' + document.querySelectorAll('.status-removed').length);
        console.log('DEBUG: Checking status-modified: ' + document.querySelectorAll('.status-modified').length);
        console.log('DEBUG: Checking status-unchanged: ' + document.querySelectorAll('.status-unchanged').length);
        console.log('DEBUG: Checking change counts: ' + document.querySelectorAll('.table-all-files tbody tr td:nth-child(3)').length);

        // Load button states from localStorage or default to Modified only
        function loadButtonStates() {
            const buttons = [
                { id: 'filter-added', key: 'filter-added-state', defaultState: false },
                { id: 'filter-removed', key: 'filter-removed-state', defaultState: false },
                { id: 'filter-modified', key: 'filter-modified-state', defaultState: true },
                { id: 'filter-unchanged', key: 'filter-unchanged-state', defaultState: false }
            ];
            buttons.forEach(button => {
                const savedState = localStorage.getItem(button.key);
                const isActive = savedState !== null ? savedState === 'true' : button.defaultState;
                const element = document.getElementById(button.id);
                element.setAttribute('data-active', isActive);
                if (isActive) {
                    element.classList.add('active', 'btn-primary');
                    element.classList.remove('btn-outline-primary');
                } else {
                    element.classList.remove('active', 'btn-primary');
                    element.classList.add('btn-outline-primary');
                }
            });
        }

        // Save button state to localStorage
        function saveButtonState(button) {
            const isActive = button.getAttribute('data-active') === 'true';
            const buttonId = button.id;
            localStorage.setItem(buttonId + '-state', isActive);
        }

        // Filter toggle logic
        function updateFilters() {
            const showAdded = document.getElementById('filter-added').getAttribute('data-active') === 'true';
            const showRemoved = document.getElementById('filter-removed').getAttribute('data-active') === 'true';
            const showModified = document.getElementById('filter-modified').getAttribute('data-active') === 'true';
            const showUnchanged = document.getElementById('filter-unchanged').getAttribute('data-active') === 'true';

            document.querySelectorAll('.table-all-files tbody tr').forEach(row => {
                if (row.classList.contains('row-status-added')) {
                    row.style.display = showAdded ? 'table-row' : 'none';
                } else if (row.classList.contains('row-status-removed')) {
                    row.style.display = showRemoved ? 'table-row' : 'none';
                } else if (row.classList.contains('row-status-modified')) {
                    row.style.display = showModified ? 'table-row' : 'none';
                } else if (row.classList.contains('row-status-unchanged')) {
                    row.style.display = showUnchanged ? 'table-row' : 'none';
                }
            });

            // Debug filter state
            console.log('DEBUG: Filter state - Added: ' + showAdded + ', Removed: ' + showRemoved + ', Modified: ' + showModified + ', Unchanged: ' + showUnchanged);
        }

        // Toggle button state
        function toggleButton(button) {
            const isActive = button.getAttribute('data-active') === 'true';
            button.setAttribute('data-active', !isActive);
            button.classList.toggle('active');
            button.classList.toggle('btn-primary');
            button.classList.toggle('btn-outline-primary');
            saveButtonState(button);
            updateFilters();
        }

        // Attach event listeners to buttons
        document.getElementById('filter-added').addEventListener('click', function() { toggleButton(this); });
        document.getElementById('filter-removed').addEventListener('click', function() { toggleButton(this); });
        document.getElementById('filter-modified').addEventListener('click', function() { toggleButton(this); });
        document.getElementById('filter-unchanged').addEventListener('click', function() { toggleButton(this); });

        // Load button states and run initial filter update
        loadButtonStates();
        updateFilters();
    </script>
</body>
</html>"""
    all_files_path = os.path.join(output_dir, "files.html")
    with open(all_files_path, 'w', encoding='utf-8') as f:
        f.write(all_files_html)
    print(f"All files HTML report saved to: {all_files_path}")

    # Generate text report
    text_report = f"Directory Comparison Report\n"
    text_report += f"Generated: {timestamp}\n"
    text_report += f"Old Directory: {dir1_path}\n"
    text_report += f"New Directory: {dir2_path}\n"
    text_report += "=" * 50 + "\n\n"

    text_report += "Summary:\n"
    text_report += f"  Added Files: {len(added_files)}\n"
    text_report += f"  Removed Files: {len(removed_files)}\n"
    text_report += f"  Modified Files: {len(modified_files)}\n"
    text_report += f"  Unchanged Files: {len(unchanged_files)}\n\n"

    if added_files:
        text_report += "Added Files:\n" + "\n".join(f"  - {f}" for f in sorted(added_files)) + "\n\n"
    if removed_files:
        text_report += "Removed Files:\n" + "\n".join(f"  - {f}" for f in sorted(removed_files)) + "\n\n"
    if modified_files:
        text_report += "Modified Files:\n" + "\n".join(f"  - {f} ({change_counts.get(f, 0)} changes)" for f in sorted(modified_files)) + "\n\n"
    if unchanged_files:
        text_report += "Unchanged Files:\n" + "\n".join(f"  - {f}" for f in sorted(unchanged_files)) + "\n\n"

    if modified_files:
        text_report += "Detailed Differences:\n"
        for relative_path in sorted(modified_files):
            text_report += f"\nDifferences in {relative_path}:\n"
            text_report += "-" * 50 + "\n"
            try:
                with open(dir1_files[relative_path], 'r', encoding='utf-8', errors='ignore') as f1, \
                     open(dir2_files[relative_path], 'r', encoding='utf-8', errors='ignore') as f2:
                    lines1 = [line.rstrip('\n') for line in f1.readlines() if line.strip()]
                    lines2 = [line.rstrip('\n') for line in f2.readlines() if line.strip()]
                    diff = difflib.unified_diff(
                        lines1, lines2,
                        fromfile=f"old/{relative_path}", tofile=f"new/{relative_path}",
                        lineterm='\n'
                    )
                    text_report += "".join(diff) + "\n"
            except (UnicodeDecodeError, IOError):
                text_report += f"Binary or unreadable file: {relative_path}\n"

    # Save text report
    text_report_path = os.path.join(output_dir, "changes.txt")
    with open(text_report_path, 'w', encoding='utf-8') as f:
        f.write(text_report)
    print(f"Text report saved to: {text_report_path}")

    # Generate main HTML report with Bootstrap, all accordions closed, 4-column grid for file lists, link to all-files page, and detailed statistics
    html_report = f"""<html>
<head>
    <title>{html.escape(title)}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {{ font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background-color: #f8f9fa; }}
        .container {{ max-width: 1200px; margin-top: 20px; }}
        .card {{ box-shadow: 0 2px 10px rgba(0,0,0,0.1); border-radius: 8px; }}
        .table {{ font-size: 14px; }}
        .accordion-button {{ font-weight: bold; }}
        a {{ color: #007bff; }}
        a:hover {{ color: #0056b3; }}
        .file-item {{ border: 1px solid #dee2e6; padding: 8px; margin-bottom: 8px; background-color: #ffffff; border-radius: 4px; }}
        .file-item a {{ color: #007bff; text-decoration: none; display: block; }}
        .file-item a:hover {{ color: #0056b3; background-color: #f1f3f5; }}
    </style>
</head>
<body>
    <div class="container">
        <h1 class="display-5 fw-bold mb-4">{html.escape(title)}</h1>
        <div class="card p-4 mb-4">
            <p><strong>{html.escape(sub_title)}</strong></p>
            <p><strong>Generated:</strong> {timestamp}</p>
            <a href="files.html" class="btn-all-files">View All Files List</a>
        </div>
        <div class="card p-4 mb-4">
            <h2 class="h4 mb-3">Summary</h2>
            <table class="table table-bordered">
                <tr><th>Category</th><th>Count</th></tr>
                <tr><td>Added Files</td><td>{len(added_files)}</td></tr>
                <tr><td>Removed Files</td><td>{len(removed_files)}</td></tr>
                <tr><td>Modified Files</td><td>{len(modified_files)}</td></tr>
                <tr><td>Unchanged Files</td><td>{len(unchanged_files)}</td></tr>
            </table>
        </div>
        <div class="card p-4 mb-4">
            <h2 class="h4 mb-3">Detailed Statistics</h2>
            <p>Additional metrics about the changes between directories.</p>
            <table class="table table-bordered">
                <tr><th>Metric</th><th>Value</th></tr>
                <tr><td>Total Lines Added (Modified Files)</td><td>{total_lines_added}</td></tr>
                <tr><td>Total Lines Removed (Modified Files)</td><td>{total_lines_removed}</td></tr>
                <tr><td>Average Change Count (Modified Files)</td><td>{avg_change_count}</td></tr>
                <tr><td>Largest File by Size</td><td>{html.escape(largest_file['path'])} ({largest_file_size}, {largest_file['status']})</td></tr>
            </table>
        </div>
        <div class="accordion" id="fileLists">
"""

    if added_files:
        html_report += f"""
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingAdded">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseAdded" aria-expanded="false" aria-controls="collapseAdded">
                    Added Files ({len(added_files)})
                </button>
            </h2>
            <div id="collapseAdded" class="accordion-collapse collapse" aria-labelledby="headingAdded" data-bs-parent="#fileLists">
                <div class="accordion-body">
                    <div class="row">
                        {"".join(f'<div class="col-12 col-sm-6 col-md-3 file-item"><a href="{html_diff_paths[f]}">{html.escape(f)}</a></div>' for f in sorted(added_files))}
                    </div>
                </div>
            </div>
        </div>
        """
    if removed_files:
        html_report += f"""
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingRemoved">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseRemoved" aria-expanded="false" aria-controls="collapseRemoved">
                    Removed Files ({len(removed_files)})
                </button>
            </h2>
            <div id="collapseRemoved" class="accordion-collapse collapse" aria-labelledby="headingRemoved" data-bs-parent="#fileLists">
                <div class="accordion-body">
                    <div class="row">
                        {"".join(f'<div class="col-12 col-sm-6 col-md-3 file-item"><a href="{html_diff_paths[f]}">{html.escape(f)}</a></div>' for f in sorted(removed_files))}
                    </div>
                </div>
            </div>
        </div>
        """
    if modified_files:
        html_report += f"""
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingModified">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseModified" aria-expanded="false" aria-controls="collapseModified">
                    Modified Files ({len(modified_files)})
                </button>
            </h2>
            <div id="collapseModified" class="accordion-collapse collapse" aria-labelledby="headingModified" data-bs-parent="#fileLists">
                <div class="accordion-body">
                    <div class="row">
                        {"".join(f'<div class="col-12 col-sm-6 col-md-3 file-item"><a href="{html_diff_paths[f]}">{html.escape(f)}</a></div>' for f in sorted(modified_files))}
                    </div>
                </div>
            </div>
        </div>
        """
    if unchanged_files:
        html_report += f"""
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingUnchanged">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUnchanged" aria-expanded="false" aria-controls="collapseUnchanged">
                    Unchanged Files ({len(unchanged_files)})
                </button>
            </h2>
            <div id="collapseUnchanged" class="accordion-collapse collapse" aria-labelledby="headingUnchanged" data-bs-parent="#fileLists">
                <div class="accordion-body">
                    <div class="row">
                        {"".join(f'<div class="col-12 col-sm-6 col-md-3 file-item"><a href="{html_diff_paths[f]}">{html.escape(f)}</a></div>' for f in sorted(unchanged_files))}
                    </div>
                </div>
            </div>
        </div>
        """

    html_report += """
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        console.log('DEBUG: Checking file items in Added section: ' + document.querySelectorAll('#collapseAdded .file-item').length);
        console.log('DEBUG: Checking file items in Removed section: ' + document.querySelectorAll('#collapseRemoved .file-item').length);
        console.log('DEBUG: Checking file items in Modified section: ' + document.querySelectorAll('#collapseModified .file-item').length);
        console.log('DEBUG: Checking file items in Unchanged section: ' + document.querySelectorAll('#collapseUnchanged .file-item').length);
    </script>
</body>
</html>
"""

    # Save main HTML report
    html_report_path = os.path.join(output_dir, "index.html")
    with open(html_report_path, 'w', encoding='utf-8') as f:
        f.write(html_report)
    print(f"Main HTML report saved to: {html_report_path}")
    if added_files or removed_files or modified_files or unchanged_files:
        print(f"Individual file HTML pages saved in: {diff_dir}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Compare two directories and generate detailed HTML and text reports of file differences.",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument(
        "dir1_path",
        type=str,
        help="Path to the first (old) directory to compare."
    )
    parser.add_argument(
        "dir2_path",
        type=str,
        help="Path to the second (new) directory to compare."
    )
    parser.add_argument(
        "--output-dir",
        type=str,
        default="report",
        help="Directory to save the reports (default: report)."
    )
    parser.add_argument(
        "--title",
        type=str,
        default="C64OS API Changes",
        help="Main title for the HTML report (default: C64OS API Changes)."
    )
    parser.add_argument(
        "--sub-title",
        type=str,
        default="Changes since last version",
        help="Subtitle for the HTML reports (default: Changes since last version)."
    )
    parser.add_argument(
        "--version",
        action="version",
        version="%(prog)s 3.0",
        help="Show program's version number and exit."
    )

    args = parser.parse_args()
    compare_directories(args.dir1_path, args.dir2_path, args.output_dir, args.title, args.sub_title)