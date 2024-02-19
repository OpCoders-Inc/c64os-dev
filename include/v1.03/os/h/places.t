;----[ places.t ]-----------------------

;link    = 0 ;Loads path.lib
;unlink  = 3 ;Unlds path.lib
             ;Frees favs and rcnts lists

ldfavs   = 6
;  Load Favorites List
;  Y <- favorites list page

ldrcnts  = 9
;  Load Recents List
;  Y <- recents list page

rdfav    = 12
;  Read a Favorite
;  X -> Index
;  RegPtr <- fref to favorite
;  Raises Exceptions

rdrcnt   = 15
;  Read a Recent
;  X -> Index
;  RegPtr <- fref to recent
;  Raises Exceptions

addfav   = 18
;  Add a Favorite
;  A  -> new favorite fref page
;  RegPtr -> favorite name
;  C  <- Clr on successful add
;  Removes existing fav by name first

addrcnt  = 21
;  Add a Recent
;  A -> new recent fref pg
;  C <- Always clear, indicating success
;  If full, oldest item is removed.
;  Newest recent is shifted into index 0
;  Removes existing rcnt by name first

