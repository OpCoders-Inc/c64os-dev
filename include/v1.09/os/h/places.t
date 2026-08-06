;----[ places.t ]-----------------------

;link    = $00 ;Loads path.lib
;unlink  = $03 ;Unlds path.lib
             ;Saves favs & rcnts changes
             ;Frees favs and rcnts lists

ldfavs   = $06
;  Load Favorites List
;  Y <- favorites list page

ldrcnts  = $09
;  Load Recents List
;  Y <- recents list page

rdfav    = $0c
;  Read a Favorite
;  X -> Index
;  RegPtr <- fref to favorite
;  Raises Exceptions

rdrcnt   = $0f
;  Read a Recent
;  X -> Index
;  RegPtr <- fref to recent
;  Raises Exceptions

addfav   = $12
;  Add a Favorite
;  A  -> new favorite fref page
;  RegPtr -> favorite name
;  C  <- Clr on successful add
;  Removes existing fav by name first

addrcnt  = $15
;  Add a Recent
;  A -> new recent fref pg
;  C <- Always clear, indicating success
;  If full, oldest item is removed.
;  Newest recent is shifted into index 0
;  Removes existing rcnt by name first

dosave   = $18
;  Save unsaved changes to favorites.
;  Save unsaved changes to recents.
;  Mark both as unmodified.

marksave = $1b
;  Mark as needing to be saved.
;  X -> 1 == Mark Favorites for save
;  Y -> 1 == Mark Recents for save

rmbyname = $1e
;  Remove list item by name.
;  ptr  -> item list    ($22;$23)
;  sptr -> name to find ($26;$27)