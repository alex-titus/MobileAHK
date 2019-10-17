Gui, Add, Tab, x2 y-1 w440 h500 , Main|Money Making|Skilling|Custom Scripts
Gui, Tab, Main
Gui, Add, Button, x12 y49 w190 h60 , Herblore
Gui, Add, Button, x232 y49 w190 h60 , Coordinate Helper
Gui, Add, Button, x12 y119 w190 h60 gResizeBluestacks, Resize Bluestacks
Gui, Add, Button, x232 y119 w190 h60 , Github
Gui, Add, Edit, x12 y349 w410 h130 vc_edit, Welcome to the Open Source AHK Mobile bot for OSRS, if this is your first time running, click "Github" and follow the instructions!
Gui, Add, Button, x12 y189 w190 h60 , Start Scripting
Gui, Add, Button, x232 y189 w190 h60 , Github
Gui, Tab, Money Making
Gui, Add, Button, x12 y49 w190 h60 , Herb Cleaning
Gui, Add, Button, x12 y119 w190 h60 , Fletching
Gui, Add, Button, x12 y189 w190 h60 , Crafting
Gui, Add, Button, x12 y259 w190 h60 , Placeholder
Gui, Add, Button, x12 y329 w190 h60 , Placeholder
Gui, Add, Button, x12 y399 w190 h60 , Placeholder
Gui, Add, DropDownList, x222 y49 w210 vherbCleanChoice, Guam|Marrentil|Tarromin|Harralander|Ranarr|Toadflax|Irit|Avantoe|Kwuarm|Snapdragon|Cadantine|Lantadym|Dwarf|Tortsol
Gui, Add, Radio, x222 y109 w65 h20 , Weapons
Gui, Add, Radio, x222 y139 w60 h20 , Arrows
Gui, Add, Radio, x222 y169 w60 h20 , Darts
Gui, Add, DropDownList, x292 y109 w140 , Shortbow (u)|Shortbow|Longbow (u)|Longbow|Oak Shortbow(u)|Oak Shortbow|Oak Longbow(u)|Oak Longbow|Willow Shortbow(u)|Willow Shortbow|Willow Longbow(u)|Willow Longbow|Maple Shortbow(u)|Maple Shortbow|Maple Longbow(u)|Maple Longbow|Yew Shortbow(u)|Yew Shortbow|Yew Longbow(u)|Yew Longbow|Magic Shortbow(u)|Magic Shortbow|Magic Longbow(u)|Magic Longbow
Gui, Add, DropDownList, x292 y139 w140 , Bronze|Iron|Steel|Mithril|Broad|Adamant|Rune|Amethyst|Dragon
Gui, Add, DropDownList, x292 y169 w140 , Bronze|Iron|Steel|Mithril|Adamant|Rune|Dragon
; Generated using SmartGUI Creator 4.0
Gui, Show, x1429 y87 h496 w440, New GUI Window
Return

GuiClose:
ExitApp

ResizeBluestacks:
  WinMove, BlueStacks, , , , 1280, 720
  return

ESC::
  ExitApp
