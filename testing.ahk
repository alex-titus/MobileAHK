; =======================================================================================
; Name ..........: AHK Bot for OSRS
; Description ...: Script Description
; AHK Version ...: AHK 1.1.30.01
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Alex Titus https://github.com/alex-titus
; =======================================================================================

; Global ================================================================================
#SingleInstance, Force ;Allow only one running instance of script
#Persistent ;Keep script permanently running until terminated
#Warn ;Enable warnings to assist with detecting common errors
SetWorkingDir, %A_ScriptDir% ;Change the working directory of the script
OnExit, ExitSub ;Run a subroutine or function automatically when the script exits

CoordMode, Mouse, Screen ;Changes coordinates to entire screen
CoordMode, Pixel, Screen ;Changes coordinates to entire screen

bluestacks_top_left_x = 0 ;ImageSearch will output x coordinats of top left corner of bluestacks here
bluestacks_top_left_y = 0 ;Imagesearch will output y coordinate of top left corner of bluestacks here
bluestacks_bottom_right_x = %A_ScreenWidth% ;ImageSearch will output x coordinate of bottom right corner of bluestacks here
bluestacks_bottom_right_y = %A_ScreenHeight% ;Imagesearch will output y coordinate of bottom right corner of bluestacks here
selected_script = "none" ;This is where the script that will be run can be saved
break_loop = 0 ;Used for breaking out of looping functions without exiting program
bank_x1 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_x2 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_y1 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_y2 = 0 ;Global variable to use for where the bank is for different bankstanding activies
output_x = 0
output_y = 0

herb_clean_choice = "" ;Global variable for cleaning herbs
weapon_fletch_choice = "" ;Gloabl variable for fletching weapons
arrow_fletch_choice = "" ;Gloabl variable for fletching arrows
dart_fletch_choice = "" ;Gloabl variable for fletching darts
; =======================================================================================

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

F12::
  click("grimy_guam.png", 25, 25, 45)
  Sleep 500
  click("grimy_marrentill.png", 25, 25, 45)
  Sleep 500
  click("grimy_tarromin.png", 25, 25, 45)
  Sleep 500
  click("grimy_harralander.png", 25, 25, 45)
  Sleep 500
  click("grimy_ranarr.png", 25, 25, 40)
  Sleep 500
  click("grimy_toadflax.png", 25, 25, 40)
  Sleep 500
  click("grimy_irit.png", 25, 25, 40)
  Sleep 500
  click("grimy_avantoe.png", 25, 25, 40)
  Sleep 500
  click("grimy_kwuarm.png", 25, 25, 30)
  Sleep 500
  click("grimy_snapdragon.png", 25, 25, 30)
  Sleep 500
  click("grimy_cadantine.png", 25, 25, 30)
  Sleep 500
  click("grimy_lantadyme.png", 25, 25, 45)
  Sleep 500
  click("grimy_dwarf.png", 25, 25, 45)
  Sleep 500
  click("grimy_torstol.png", 25, 25, 45)
  Sleep 500
  guiDebug(output_x output_y)
  Return

ESC::
  ExitApp


ExitSub:
	ExitApp ;Exits the script completely

guiDebug(message){
  c_text = c_text
  GuiControlGet, c_text,,c_edit
  FormatTime, currentTime, , h:mm:ss tt
  GuiControl,, c_edit, %currentTime%: %message%`n%c_text%
}

inventoryClick(image, size_x, size_y, trans_var_inventory){
	totalClicks = 0 ;Total amount of times the item has been found
	items_in_row = 0 ;Counting the amount of times in a row the items has been found
	total_errors = 0 ;Calculating total errors, allows for early terminatino
  global output_x = 0 ;ImageSearch will output x coordinates here
  global output_y = 0 ;Imagesearch will output y coordinates here
  move_temp_x = 0 ;Will be used to start searching for next item
  move_temp_y = 0 ;Will be used to start searching for next item
  randX = 0 ;Init value for randX
  randY = 0 ;Init value for randY
	while (totalClicks < 5){
		ImageSearch, output_x, output_y, move_temp_x, output_y, 1920, 1080, *TransBlack *%trans_var_inventory% %A_WorkingDir%\images\%image%
		guiDebug("found at x:" output_x " y:" output_y) ;Logs current coords of the item
		items_in_row := items_in_row + 1
		Random, randX, 2, size_x ;Random x value increment for humanlike difference
		Random, randY, 2, size_y ;Random y value increment for humanlike difference
		tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
		tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
		if (ErrorLevel = 0){ ;The item was found on screen
      MouseMove, tempX, tempY
			Click
		}
		if (ErrorLevel = 1){ ;The item wasn't found on screen
      guiDebug(image " wasn't found on scren")
			total_errors++
		}
		if (total_errors == 4){ ;If we haven't found the item in 2 times, exit
			break
		}

		if (items_in_row == 4){
      ;If we found 4 items in a row, go down and over to next row
			output_y := output_y + 25
			move_temp_x := output_x - 240
			items_in_row := 0
		} else {
      ;Start our search for next item 1 pixels greater than where the last was found
			move_temp_x := output_x + 25
    }
		totalClicks++
	} ;Allows us to click every item in inventory ;Clicks all specific items in inventory
}


click(image, size_x, size_y, trans_var_click){
  global output_x = 0 ;ImageSearch will output x coordinates here
  global output_y = 0 ;Imagesearch will output y coordinates here
  ImageSearch, output_x, output_y, 0, 0, 1920, 1080, *TransBlack *%trans_var_click% %A_WorkingDir%\images\%image%
  if(ErrorLevel = 0){
    ;guiDebug("found at x:" output_x " y:" output_y) ;Logs current coords of the item
    Random, randX, 3, size_x - 2 ;Random x value increment for humanlike difference
    Random, randY, 3, size_y - 2 ;Random y value increment for humanlike difference
    tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
    tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
    MouseMove, tempX, tempY
    ;Click
    return 0
  } else if (ErrorLevel = 1){
    ;guiDebug(image " not found")
    return 1
  } ;Allows us to click a single object anywhere ;Clicks a specific image on screen
}
