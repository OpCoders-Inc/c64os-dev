;----[ menu.t ]-------------------------

lmnu     = $0100-(2*6)       ;6th Module

mnudraw_ = 0
;Causes the menu system to redraw its
;current state.

mnumouse_ = 3
;Passes mouse events to the menu system.

mnukcmd_ = 6
;Passes kcmd events to the menu system.

deactiv_ = 9
;Sets mnuactiv low, and closes all open
;menus. Should be called by any process
;that is drawing suddenly taking control
;away from an app.
;Loader and crashrecover.r call this.




