;----[ menu.t ]-------------------------

lmnu     = $0100-(2*6)       ;6th Module

mnudraw_ = $00
;Causes the menu system to redraw its
;current state.

mnumouse_ = $03
;Passes mouse events to the menu system.

mnukcmd_ = $06
;Passes kcmd events to the menu system.

deactiv_ = $09
;Sets mnuactiv low, and closes all open
;menus. Should be called by any process
;that is drawing suddenly taking control
;away from an app.
;Loader and crashrecover.r call this.