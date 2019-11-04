; =======================================================================================
; Name ..........: AHK Bot for OSRS
; Description ...: Script Description
; AHK Version ...: AHK 1.1.30.01
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: Alex Titus https://github.com/alex-titus
; =======================================================================================

; Changelog =============================================================================
; Legend: (+) NEW, (*) CHANGED, (!) FIXED
; ---------------------------------------------------------------------------------------
; 9/27/2019  Alex Titus  https://github.com/alex-titus
; + Initial Push
; + First Attempts at creating
; 9/28/2019
; + Too much work to update this, check the github commit log please + thanks
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

herb_clean_choice = "" ;Global variable for cleaning herbs
herb_potion_choice = "" ;Global variable for creating (unf) potions
weapon_fletch_choice = "" ;Gloabl variable for fletching weapons
arrow_fletch_choice = "" ;Gloabl variable for fletching arrows
dart_fletch_choice = "" ;Gloabl variable for fletching darts

; =======================================================================================

; Script ================================================================================
findBluestacks() ;Find bluestacks so we know where to search for images later on
Gui, Add, Tab, x2 y-1 w440 h500 , Main|Money Making|Skilling
Gui, Tab, Main
Gui, Add, Button, x12 y49 w190 h60 , Set Coordinates
Gui, Add, Button, x232 y49 w190 h60 , Coordinate Helper
Gui, Add, Button, x12 y119 w190 h60 gResizeBluestacks, Resize Bluestacks
Gui, Add, Button, x232 y119 w190 h60 gGithub, Github
Gui, Add, Edit, x12 y349 w410 h130 vc_edit, Welcome to the Open Source AHK Mobile bot for OSRS, if this is your first time running, click "Github" and follow the instructions!
Gui, Add, Button, x12 y189 w190 h60 gStartScripting, Start Scripting
Gui, Add, Button, x232 y189 w190 h60 , Github
Gui, Tab, Money Making
Gui, Add, Button, x12 y49 w190 h60 gHerbCleaning, Herb Cleaning
Gui, Add, Button, x12 y119 w190 h60 gFletching, Fletching
Gui, Add, Button, x12 y189 w190 h60 gPotionMaking, (Unf) Potion Mixing
Gui, Add, Button, x12 y259 w190 h60 , Placeholder
Gui, Add, Button, x12 y329 w190 h60 , Placeholder
Gui, Add, Button, x12 y399 w190 h60 , Placeholder
Gui, Add, DropDownList, x222 y49 w210 vherb_clean_choice, guam||marrentill|tarromin|harralander|ranarr|toadflax|irit|avantoe|kwuarm|snapdragon|cadantine|lantadym|dwarf|tortsol
Gui, Add, DropDownList, x222 y190 w210 vherb_potion_choice, guam||marrentill|tarromin|harralander|ranarr|toadflax|irit|avantoe|kwuarm|snapdragon|cadantine|lantadym|dwarf|tortsol
Gui, Add, DropDownList, x292 y109 w140 vweapon_fletch_choice, Shortbow_(u)||Shortbow|Longbow_(u)|Longbow|Oak_Shortbow(u)|Oak_Shortbow|Oak_Longbow(u)|Oak_Longbow|Willow_Shortbow(u)|Willow_Shortbow|Willow_Longbow(u)|Willow_Longbow|Maple_Shortbow(u)|Maple_Shortbow|Maple_Longbow(u)|Maple_Longbow|Yew_Shortbow(u)|Yew_Shortbow|Yew_Longbow(u)|Yew_Longbow|Magic_Shortbow(u)|Magic_Shortbow|Magic_Longbow(u)|Magic_Longbow
Gui, Add, DropDownList, x292 y139 w140 varrow_fletch_choice, Bronze||Iron|Steel|Mithril|Broad|Adamant|Rune|Amethyst|Dragon
Gui, Add, DropDownList, x292 y169 w140 vdart_fletch_choice, Bronze||Iron|Steel|Mithril|Adamant|Rune|Dragon
Gui, Add, Radio, x222 y109 w65 h20 vfletching_radio_group, Weapons
Gui, Add, Radio, x222 y139 w60 h20 , Arrows
Gui, Add, Radio, x222 y169 w60 h20 , Darts
; Generated using SmartGUI Creator 4.0
Gui, Show, x1429 y87 h496 w440, New GUI Window
return

F12::
  guiDebug("Stopping running script")
  break_loop = 1
  return

ESC::
  ExitApp

F11::
  Send, ^s ; To save a changed script
  Sleep, 300 ; give it time to save the script
  Reload
  Return
; =======================================================================================

; Labels For Selecting a Script =========================================================
StartScripting:
  if selected_script = "none"
  {
    guiDebug("Please select a script and try again")
    return
  }
  else if selected_script = "herb_cleaning"
  {
    herbCleaning()
    return
  }
  else if selected_script = "potion_making"
  {
    potionMaking()
    return
  }
  else if selected_script = "weapon_fletching"
  {
    weaponFletching()
    return
  }
  else if selected_script = "arrow_fletching"
  {
    arrowFletching()
    return
  }
  else if selected_script = "dart_fletching"
  {
    dartFletching()
    return
  }
  return

HerbCleaning:
  Gui, Submit, NoHide
  selected_script = "herb_cleaning"
  guiDebug("Currented selected script: grimy " herb_clean_choice " cleaning")
  return

PotionMaking:
  Gui, Submit, NoHide
  selected_script = "potion_making"
  guiDebug("Currented selected script: " herb_potion_choice " mixing")
  return

Fletching:
  Gui, Submit, NoHide
  if (fletching_radio_group = 1){
    selected_script = "weapon_fletching"
    guiDebug("Currented selected script: Fletching " weapon_fletch_choice)
  } else if (fletching_radio_group = 2){
    selected_script = "arrow_fletching"
    guiDebug("Currented selected script: Fletching " arrow_fletch_choice)
  } else if (fletching_radio_group = 3){
    selected_script = "dart_fletching"
    guiDebug("Currented selected script: Fletching " dart_fletch_choice)
  }
  return

Github:
  Run, https://github.com/alex-titus/MobileAHK
  return

ResizeBluestacks:
  WinMove, BlueStacks, , , , 1280, 720
  return

GuiEscape:

GuiClose:

ExitSub:
	ExitApp ;Exits the script completely
; =======================================================================================

; General Use Functions =================================================================
guiDebug(message){
  c_text = c_text
  GuiControlGet, c_text,,c_edit
  FormatTime, currentTime, , h:mm:ss tt
  GuiControl,, c_edit, %currentTime%: %message%`n%c_text%
}

RandSleep(x,y) { ;Allows for a random sleep between a given X and Y value
	Random, rand, %x%, %y%
	Sleep %rand%
}

distributedRandSleep(x, y){
  average_sleep := (x+y)/2
  distribution_sleep := (y-x)/4 ;StDev number
  Random, random, 1, 100
  if (random >= 1 and random <= 50){
    Random, random_sleep, average_sleep-distribution_sleep, average_sleep+distribution_sleep
  } else if (random > 50 and random <= 60){
    Random, random_sleep, average_sleep-(2*distribution_sleep), average_sleep+(2*distribution_sleep)
  } else if (random > 60 and random <= 80){
    Random, random_sleep, average_sleep-(3*distribution_sleep), average_sleep+(3*distribution_sleep)
  } else {
    Random, random_sleep, average_sleep-(4*distribution_sleep), average_sleep+(4*distribution_sleep)
  }
  ;guiDebug("Sleeping for: " random_sleep/1000 " seconds")
  Sleep %random_sleep%
}

findBluestacks(){
  global bluestacks_top_left_x = 0 ;ImageSearch will output x coordinats of top left corner of bluestacks here
  global bluestacks_top_left_y = 0 ;Imagesearch will output y coordinate of top left corner of bluestacks here
  global bluestacks_bottom_right_x = 0 ;ImageSearch will output x coordinate of bottom right corner of bluestacks here
  global bluestacks_bottom_right_y = 0 ;Imagesearch will output y coordinate of bottom right corner of bluestacks here

  guiDebug("Searching for bluestacks...")

  ImageSearch, bluestacks_top_left_x, bluestacks_top_left_y, 0, 0, 1920, 1080, *20 %A_WorkingDir%\images\bluestacks_icon.png
  if (ErrorLevel = 0){
    guiDebug("Top left of bluestacks found at x:" bluestacks_top_left_x " y:" bluestacks_top_left_y) ;Logs coordinates of top left corner of bank
  } else if (ErrorLevel = 1){
    guiDebug("Unable to find top left corner of the bluestacks...")
  }

  ImageSearch, bluestacks_bottom_right_x, bluestacks_bottom_right_y, 0, 0, 1920, 1080, *20 %A_WorkingDir%\images\bluestacks_back.png
  if (ErrorLevel = 0){
    guiDebug("Bottom right of bank found at x:" bluestacks_bottom_right_x " y:" bluestacks_bottom_right_y) ;Logs coordinates of bottom right corner of bank
  } else if (ErrorLevel = 1){
    guiDebug("Unable to find top left corner of the bluestacks...")
  } ;Allows us to find Bluestacks, no real use yet tho
}

inventoryClick(image, size_x, size_y, trans_var){
	totalClicks = 0 ;Total amount of times the item has been found
	items_in_row = 0 ;Counting the amount of times in a row the items has been found
	total_errors = 0 ;Calculating total errors, allows for early terminatino
  output_x = 0 ;ImageSearch will output x coordinates here
  output_y = 0 ;Imagesearch will output y coordinates here
  move_temp_x = 0 ;Will be used to start searching for next item
  move_temp_y = 0 ;Will be used to start searching for next item
  randX = 0 ;Init value for randX
  randY = 0 ;Init value for randY
	while (totalClicks < 28){
		ImageSearch, output_x, output_y, move_temp_x, output_y, 1920, 1080, *TransBlack *%trans_var% %A_WorkingDir%\images\%image%
		;guiDebug("found at x:" output_x " y:" output_y) ;Logs current coords of the item
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
      ;guiDebug(image " wasn't found on scren")
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
		RandSleep(20, 45)
		totalClicks++
	} ;Allows us to click every item in inventory ;Clicks all specific items in inventory
}

click(image, size_x, size_y, trans_var){
  output_x = 0 ;ImageSearch will output x coordinates here
  output_y = 0 ;Imagesearch will output y coordinates here
  ImageSearch, output_x, output_y, 0, 0, 1920, 1080, *TransBlack *%trans_var% %A_WorkingDir%\images\%image%
  if(ErrorLevel = 0){
    ;guiDebug("found at x:" output_x " y:" output_y) ;Logs current coords of the item
    Random, randX, 3, size_x - 2 ;Random x value increment for humanlike difference
    Random, randY, 3, size_y - 2 ;Random y value increment for humanlike difference
    tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
    tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
    MouseMove, tempX, tempY
    Click
    return 0
  } else if (ErrorLevel = 1){
    ;guiDebug(image " not found")
    return 1
  } ;Allows us to click a single object anywhere ;Clicks a specific image on screen
}

findInBank(item){
  bank_top_left_x = 0 ;ImageSearch will output x coordinats of top left corner of bank here
  bank_top_left_y = 0 ;Imagesearch will output y coordinate of top left corner of bank here
  bank_bottom_right_x = 0 ;ImageSearch will output x coordinate of bottom right corner of bank here
  bank_bottom_right_y = 0 ;Imagesearch will output y coordinate of bottom right corner of bank here
  item_coordinate_x = 0 ;Imagesearch will output x coordinate of item here
  item_coordinate_y = 0 ;Imagesearch will output y coordinate of item here
  global bluestacks_top_left_x ;ImageSearch will start the search from here
  global bluestacks_top_left_y ;ImageSearch will start the search from here
  global bluestacks_bottom_right_x ;ImageSearch will start the search from here
  global bluestacks_bottom_right_y ;ImageSearch will start the search from here

  guiDebug("Searching for bank...")

  ImageSearch, bank_top_left_x, bank_top_left_y, bluestacks_top_left_x, bluestacks_top_left_y, bluestacks_bottom_right_x, bluestacks_bottom_right_y, *50 %A_WorkingDir%\images\top_left_corner_bank.png
  if (ErrorLevel = 0){
    guiDebug("Top left of bank found at x:" bank_top_left_x " y:" bank_top_left_y) ;Logs coordinates of top left corner of bank
  } else if (ErrorLevel = 1){
    guiDebug("Unable to find top left corner of the bank...")
  }

  ImageSearch, bank_bottom_right_x, bank_bottom_right_y, bluestacks_top_left_x, bluestacks_top_left_y, bluestacks_bottom_right_x, bluestacks_bottom_right_y, *50 %A_WorkingDir%\images\bank_equipment.png
  if (ErrorLevel = 0){
    guiDebug("Bottom right of bank found at x:" bank_bottom_right_x " y:" bank_bottom_right_y) ;Logs coordinates of bottom right corner of bank
  } else if (ErrorLevel = 1){
    guiDebug("Unable to find bottom right corner of the bank...")
  }

  ImageSearch, item_coordinate_x, item_coordinate_y, bank_top_left_x, bank_top_left_y, bank_bottom_right_x, bank_bottom_right_y, *40 %A_WorkingDir%\images\%item%
  if (ErrorLevel = 0){
    guiDebug("Item found at x:" item_coordinate_x " y:" item_coordinate_y) ;Logs coordinates of bottom right corner of bank
    return 0
  } else if (ErrorLevel = 1){
    guiDebug("Unable to find item in the bank...")
    return 1
  } ;Used to find if an item is found in the bank, can also set bank coords for future use ;If you're trying to find in bank a certain item (check for 0)
}

bellCurveClick(dimension_x1, dimension_x2, dimension_y1, dimension_y2){ ;Attemps at creating standard deviation clicking
  ;This entire function will be used as a decent antiban. It's not very human
  ;for clicking on an object to be completely and utterly random.
  ;Usually we will gravitate towards the center of something.
  ;10/100 chance it's on the extreme edge (N+3 or N-3, 10%)
  ;26/100 chance it's on the normal edge (N+2 or N-2, 26%)
  ;64/100 chance it's within a normal range (N+1 or N-1, 64%)
  average_x := (dimension_x1+dimension_x2)/2 ;Midpoint of the x
  average_y := (dimension_y1+dimension_y2)/2 ;Midpoint of the y
  distribution_x := (dimension_x2-dimension_x1)/6 ;StDev number
  distribution_y := (dimension_y2-dimension_y1)/6 ;StDev number
  ;MsgBox, average_x: %average_x% average_y: %average_y% distribution_x: %distribution_x% distribution_y: %distribution_y%
  Random, random_number_x, 1, 100
  if(random_number_x <= 5){
    ;Generate clicking on far left
    Random, random_x, dimension_x1, dimension_x1+distribution_x
  } else if (random_number_x >= 95){
    ;Generate clicking on far right
    Random, random_x, dimension_x2-distribution_x, dimension_x2
  } else if (random_number_x > 5) and (random_number_x < 19){
    ;Generate clicking on moderate left
    Random, random_x, dimension_x1+distribution_x, dimension_x1+(2*distribution_x)
  } else if (random_number_x > 81) and (random_number_x < 95){
    ;Generate clicking on moderate right
    Random, random_x, dimension_x2-(2*distribution_x), dimension_x2-distribution_x
  } else {
    ;Generate clicking in the middle somewhere
    Random, random_x, dimension_x1+(2*distribution_x), dimension_x2-(2*distribution_x)
  }

  Random, random_number_y, 1, 100
  if(random_number_y < 5){
    ;Generate clicking on far bottom
    Random, random_y, dimension_y1, dimension_y1+distribution_y
  } else if (random_number_y >= 95){
    ;Generate clicking on far top
    Random, random_y, dimension_y2-distribution_y, dimension_y2
  } else if (random_number_y > 5) and (random_number_y < 19){
    ;Generate clicking on moderate top
    Random, random_y, dimension_y1+distribution_y, dimension_y1+(2*distribution_y)
  } else if (random_number_y > 81) and (random_number_y < 95){
    ;Generate clicking on moderate bottom
    Random, random_y, dimension_y2-(2*distribution_y), dimension_y2-distribution_y
  } else {
    ;Generate clicking in the middle somewhere
    Random, random_y, dimension_y1+(2*distribution_y), dimension_y2-(2*distribution_y)
  }

  MouseClick, left, random_x, random_y
  return 0
}

humanClick(dimension_x1, dimension_x2, dimension_y1, dimension_y2){ ;Better clicking function
  ;Attempting to move the "hard" borders that generate with bellCurveClick
  average_x := (dimension_x1+dimension_x2)/2 ;Midpoint of the x
  average_y := (dimension_y1+dimension_y2)/2 ;Midpoint of the y
  radius_x := (dimension_x2-dimension_x1)/2 ;Radius of x coordinate
  radius_y := (dimension_y2-dimension_y1)/2 ;Radius of y coordinate
  distribution_x := (dimension_x2-dimension_x1)/4 ;StDev number
  distribution_y := (dimension_y2-dimension_y1)/4 ;StDev number
  ;MsgBox, average_x: %average_x% average_y: %average_y% distribution_x: %distribution_x% distribution_y: %distribution_y%

  Random, random_number, 1, 100
  if (random_number <= 10){
    if(radius_x >= radius_y){
      circleClick(average_x, average_y, radius_y/3)
    } else {
      circleClick(average_x, average_y, radius_x/3)
    }
  } else if(random_number <= 25){
    if(radius_x >= radius_y){
      circleClick(average_x, average_y, radius_y/2)
    } else {
      circleClick(average_x, average_y, radius_x/2)
    }
  } else if(random_number <= 50){
    if(radius_x >= radius_y){
      circleClick(average_x, average_y, radius_y)
    } else {
      circleClick(average_x, average_y, radius_x)
    }
  } else if(random_number <= 52){
    ;Generate clicking on top left
    Random, random_x, dimension_x1, dimension_x1+distribution_x
    Random, random_y, dimension_y1, dimension_y1+distribution_y
    MouseClick, Left, random_x, random_y

  } else if (random_number <= 54){
    ;Generate clicking on top right
    Random, random_x, dimension_x2-distribution_x, dimension_x2
    Random, random_y, dimension_y1, dimension_y1+distribution_y
    MouseClick, Left, random_x, random_y

   } else if (random_number <= 56){
    ;Generate clicking on bottom left
    Random, random_x, dimension_x1, dimension_x1+distribution_x
    Random, random_y, dimension_y2-distribution_y, dimension_y2
    MouseClick, Left, random_x, random_y

  } else if (random_number <= 58){
    ;Generate clicking on bottom right
    Random, random_x, dimension_x2-distribution_x, dimension_x2
    Random, random_y, dimension_y2-distribution_y, dimension_y2
    MouseClick, Left, random_x, random_y


  } else if(random_number <= 61){
    ;Generate clicking on middle left
    Random, random_x, dimension_x1, dimension_x1+distribution_x
    Random, random_y, dimension_y1+distribution_y, dimension_y1+(3*distribution_y)
    MouseClick, Left, random_x, random_y

  } else if (random_number <= 64){
    ;Generate clicking on middle right
    Random, random_x, dimension_x2-distribution_x, dimension_x2
    Random, random_y, dimension_y1+distribution_y, dimension_y1+(3*distribution_y)
    MouseClick, Left, random_x, random_y

  } else {
    ;Generate clicking in the middle somewhere
    Random, random_x, average_x+(1.5*distribution_x), average_x-(1.5*distribution_x)
    Random, random_y, average_y+(1.5*distribution_y), average_y-(1.5*distribution_y)
    MouseClick, Left, random_x, random_y
  }
  return
}

circleClick(x_center, y_center, circle_radius){
  Random, radius, 0, (circle_radius*circle_radius)
  Random, angle, 0, 6.28319
  x_center += Cos(angle)*(Sqrt(radius))
  y_center += Sin(angle)*(Sqrt(radius))

  MouseClick, Left, x_center, y_center
}

askForBankCoords(){ ;Asks uses for an upper left and bottom right coords
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies

  MsgBox, ,Bank Coordinate Finder, Right click on the upper lefthand corner of the bank, then left click bottom righthand

  KeyWait, RButton, d
  MouseGetPos, bank_x1, bank_y1
  KeyWait, LButton, d
  MouseGetPos, bank_x2, bank_y2
  return
}

antiban(percentage){
  ;The idea is to have each antiban have a randomized action, and appear randomly
    ;It could be possibile for the first aniban action to log out for 45 minutes, or join a CC
  ;General (Any Skill) Antiban ideas:
    ;Computer specific randomiziations
      ;If they will usually click banker or bank stall
      ;If they drop items going across then down, or down then across
      ;If they take more short breaks, or more medium breaks
      ;If they bank by clicking "bank all" or the items in inventory
      ;If they check their xp often, or barely at all
    ;MISCLICK!!! Humans aren't perfect, this is important
      ;Every click has a 2% chance of messing up? Can change randomly
    ;Checking current skill being trained XP
    ;Going "afk" from the phone, not logging out
    ;Checking friends list for online friends
    ;Checking GE offers
    ;Join / Leave a CC, type in CC
    ;Add someone to ignore
    ;PM a friend
    ;Swapping skills
    ;Logging out for 6-8 minutes (simulate checking another app)
    ;Logging out for 25-35 minutes (simulate getting bored / something else)
  ;Skill Specific========================================================================
  ;Fletching
    ;Creating shortbows instead of longbows
    ;Knife -> Logs?
    ;Logs -> Knife?
    ;Bow String -> (u)?
    ;(u) -> Bow string? ;Pretty obvious
    Random, antiban_chance, 0, 100
    if(antiban_chance <= percentage){
      Random, antiban_activity, 0, 100
      if(antiban_activity >= 0 and antiban_activity <= 75){
        guiDebug("Antiban sleeping between 13 and 25 seconds")
        distributedRandSleep(13000, 25000)
      } else if (antiban_activity > 75){
        guiDebug("Antiban sleeping between 30 and 60 seconds")
        distributedRandSleep(30000, 60000)
      }
    }
}


; =======================================================================================
; Specific Skill Functions ==============================================================
herbCleaning(){
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  global herb_clean_choice
  guiDebug("Starting script: grimy " herb_clean_choice " cleaning")
  guiDebug("Asking for bank coordinates")
  askForBankCoords()
  guiDebug("Bank coordinates set, starting script")
  distributedRandSleep(1500, 3000)
  global break_loop = 0
  global loop_errors = 0
  Loop {
    if (break_loop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
      break
      guiDebug("Failed to bank inventory 5 times, exiting script")
    }
    guiDebug("Rolling for antiban")
    antiban(5)
    ;Assume our bank is open now, deposit anything in inventory
    if (click("bank_inventory.png", 50, 50, 55) = 0){ ;Successfully banked everything in our inventory
      loop_errors = 0 ;reset our amount of errors
      distributedRandSleep(600, 900) ;Sleep between 1 to 1.5 ticks
      if (click("grimy_" herb_clean_choice ".png", 27, 21, 55) = 0){ ;Withdraw our herb from bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        click("bank_close.png", 34, 34, 55) ;Close the bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        guiDebug("Cleaning herbs") ;Outputs Cleaning herbs to the gui
        inventoryClick("grimy_" herb_clean_choice ".png", 27, 21, 55) ;Clean our inventory of herbs
        bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank ;Open our bank
        distributedRandSleep(900, 1200) ;Sleep between 1 to 1.5 ticks
      } else { ;Our last withdraw didn't work, so try again
        click("grimy_" herb_clean_choice ".png", 27, 21, 55) ;Withdraw our herb from bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        click("bank_close.png", 34, 34, 55) ;Close the bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        guiDebug("Cleaning herbs") ;Outputs Cleaning herbs to the gui
        inventoryClick("grimy_" herb_clean_choice ".png", 27, 21, 55) ;Clean our inventory of herbs
        bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
        distributedRandSleep(900, 1200) ;Sleep between 1 to 1.5 ticks
      }
    } else {
      loop_errors++ ;Increment errors, so we can break if something is wrong
      ;We did not open our bank, so must open it
      bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
      distributedRandSleep(900, 1200) ;Sleep between 1 to 1.5 ticks
    }
  }
  return
}

potionMaking(){
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  global herb_potion_choice
  guiDebug("Starting script: mixing " herb_potion_choice "unf")
  guiDebug("Asking for bank coordinates")
  askForBankCoords()
  guiDebug("Bank coordinates set, starting script")
  distributedRandSleep(1500, 3000)
  global break_loop = 0
  global loop_errors = 0
  Loop {
    if (break_loop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
      break
      guiDebug("Failed to bank inventory 5 times, exiting script")
    }
    guiDebug("Rolling for antiban")
    antiban(2)
    ;Assume our bank is open now, deposit anything in inventory
    if (click("bank_inventory.png", 50, 50, 55) = 0){ ;Successfully banked everything in our inventory
      loop_errors = 0 ;reset our amount of errors
      distributedRandSleep(900, 1200) ;Sleep between 1.2 to 2 ticks
      if (click("clean_" herb_potion_choice ".png", 27, 21, 55) = 0){ ;Successfully withdraw our herbs from bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        click("vial_of_water.png", 14, 12, 25) ;Withdraw our water
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        click("bank_close.png", 34, 34, 55) ;Close the bank
        distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
        click("clean_" herb_potion_choice ".png", 27, 21, 55) ;Click our herbs
        distributedRandSleep(150, 300) ;Sleep between .25 to .5 tick
        click("vial_of_water.png", 14, 12, 25) ;Click our water
        distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
        if(click(herb_potion_choice "_potion(unf).png", 120, 90, 50) = 0){ ;Successfully clicked our potion choice
          guiDebug("Creating potions " herb_potion_choice)
          distributedRandSleep(10000, 13000) ;Sleep between 51 and 58 seconds
        }
        humanClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
        distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
      }
    } else {
      loop_errors++ ;Increment errors, so we can break if something is wrong
      ;We did not open our bank, so must open it
      bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
      distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
    }
  }
  return
}

weaponFletching(){
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  global weapon_fletch_choice
  global stringing = 0
  global logs = ""
  global break_loop = 0
  global loop_errors = 0
  if (weapon_fletch_choice = "Shortbow_(u)" or weapon_fletch_choice = "Longbow_(u)"){
    stringing := 0
    logs := "logs.png"
  } else if (weapon_fletch_choice = "Shortbow" or weapon_fletch_choice = "Longbow"){
    stringing := 1
  } else if (weapon_fletch_choice = "Oak_Shortbow(u)" or weapon_fletch_choice = "Oak_Longbow(u)"){
    stringing := 0
    logs := "oak_logs.png"
  } else if (weapon_fletch_choice = "Oak_Shortbow" or weapon_fletch_choice = "Oak_Longbow"){
    stringing := 1
  } else if (weapon_fletch_choice = "Willow_Shortbow(u)" or weapon_fletch_choice = "Willow_Longbow(u)"){
    stringing := 0
    logs := "willow_logs.png"
  } else if (weapon_fletch_choice = "Willow_Shortbow" or weapon_fletch_choice = "Willow_Longbow"){
    stringing := 1
  } else if (weapon_fletch_choice = "Maple_Shortbow(u)" or weapon_fletch_choice = "Maple_Longbow(u)"){
    stringing := 0
    logs := "maple_logs.png"
    trans_var := 30
  } else if (weapon_fletch_choice = "Maple_Shortbow" or weapon_fletch_choice = "Maple_Longbow"){
    stringing := 1
    trans_var := 30
  } else if (weapon_fletch_choice = "Yew_Shortbow(u)" or weapon_fletch_choice = "Yew_Longbow(u)"){
    stringing := 0
    logs := "yew_logs.png"
  } else if (weapon_fletch_choice = "Yew_Shortbow" or weapon_fletch_choice = "Yew_Longbow"){
    stringing := 1
  } else if (weapon_fletch_choice = "Magic_Shortbow(u)" or weapon_fletch_choice = "Magic_Longbow(u)"){
    stringing := 0
    logs := "magic_logs.png"
  } else if (weapon_fletch_choice = "Magic_Shortbow" or weapon_fletch_choice = "Magic_Longbow"){
    stringing := 1
  }

  guiDebug("Starting script: fletching " weapon_fletch_choice)
  guiDebug("Asking for bank coordinates")
  askForBankCoords()
  guiDebug("Bank coordinates set, starting script")
  distributedRandSleep(1500, 3000)
  if (stringing = 0){ ;Fletching unstrung bows
    Loop {
      if (break_loop = 1){ ;Used to break out of any function when pressing F12
        break
      }
      if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
        break
        guiDebug("Failed to bank inventory 5 times, exiting script")
      }
      guiDebug("Rolling for antiban")
      antiban(5)
      ;Assume our bank is open now, deposit anything in inventory
      if (click("bank_inventory.png", 50, 50, 55) = 0){ ;Successfully banked everything in our inventory
        loop_errors = 0 ;reset our amount of errors
        distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
        if (click(logs, 26, 17, trans_var) = 0){ ;Successfully withdraw our logs from bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click("bank_close.png", 34, 34, 55) ;Close the bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click(logs, 26, 17, trans_var) ;Click our logs
          distributedRandSleep(150, 300) ;Sleep between .25 to .5 tick
          click("knife.png", 5, 11, 20) ;Click our knife
          distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
          if(click("Fletch_" weapon_fletch_choice ".png", 127, 99, 50) = 0){ ;Successfully clicked our fletching
            guiDebug("Fletching " weapon_fletch_choice)
            distributedRandSleep(51000, 58000) ;Sleep between 51 and 58 seconds
          }
          humanClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
          distributedRandSleep(600, 900) ;Sleep between 1 to 1.5 ticks
        } else {
          click(logs, 26, 17, trans_var) ;Try to wtihdraw logs
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click("bank_close.png", 34, 34, 55) ;Close the bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click(logs, 26, 17, trans_var) ;Click our logs
          distributedRandSleep(150, 300) ;Sleep between .25 to .5 tick
          click("knife.png", 5, 11, 20) ;Click our knife
          distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
          if(click("Fletch_" weapon_fletch_choice ".png", 127, 99, 50) = 0){ ;Successfully clicked our fletching
            guiDebug("Fletching " weapon_fletch_choice)
            distributedRandSleep(47000, 53000) ;Sleep between 47 and 53 seconds
          }
          humanClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
          distributedRandSleep(600, 900) ;Sleep between 1 to 1.5 ticks
        }
      } else {
        loop_errors++ ;Increment errors, so we can break if something is wrong
        ;We did not open our bank, so must open it
        bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
        distributedRandSleep(900, 1200) ;Sleep between 1 to 1.5 ticks
      }
    }
  } else if (stringing = 1){ ;Stringing bows
    click("withdraw_x.png", 34, 30, 25) ;Make sure we are using withdraw_x
    guiDebug("Here")
    Loop {
      if (break_loop = 1){ ;Used to break out of any function when pressing F12
        break
      }
      if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
        break
        guiDebug("Failed to bank inventory 5 times, exiting script")
      }
      guiDebug("Rolling for antiban")
      antiban(5)
      ;Assume our bank is open now, deposit anything in inventory
      if (click("bank_inventory.png", 50, 50, 55) = 0){ ;Successfully banked everything in our inventory
        loop_errors = 0 ;reset our amount of errors
        distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
        if (click(weapon_fletch_choice ".png", 26, 17, trans_var) = 0){ ;Successfully withdraw our weapon from bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click("bowstring.png", 5, 11, 20) ;
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click("bank_close.png", 34, 34, 55) ;Close the bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click(weapon_fletch_choice ".png", 26, 17, trans_var) ;Click our (u) bow
          distributedRandSleep(150, 300) ;Sleep between .25 to .5 tick
          click("bowstring.png", 5, 11, 20) ;Click our knife
          distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
          if(click("Fletch_" weapon_fletch_choice ".png", 127, 99, 50) = 0){ ;Successfully clicked our fletching
            guiDebug("Fletching " weapon_fletch_choice)
            distributedRandSleep(51000, 58000) ;Sleep between 51 and 58 seconds
          }
          humanClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
          distributedRandSleep(600, 900) ;Sleep between 1 to 1.5 ticks
        } else {
          click(weapon_fletch_choice ".png", 26, 17, trans_var) ;Try to wtihdraw logs
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click("bank_close.png", 34, 34, 55) ;Close the bank
          distributedRandSleep(450, 750) ;Sleep between .75 to 1.25 ticks
          click(weapon_fletch_choice ".png", 26, 17, trans_var) ;Click our logs
          distributedRandSleep(150, 300) ;Sleep between .25 to .5 tick
          click("knife.png", 5, 11, 20) ;Click our knife
          distributedRandSleep(900, 1200) ;Sleep between 1.5 to 2 ticks
          if(click("Fletch_" weapon_fletch_choice ".png", 127, 99, 50) = 0){ ;Successfully clicked our fletching
            guiDebug("Fletching " weapon_fletch_choice)
            distributedRandSleep(47000, 53000) ;Sleep between 47 and 53 seconds
          }
          humanClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
          distributedRandSleep(600, 900) ;Sleep between 1 to 1.5 ticks
        }
      } else {
        loop_errors++ ;Increment errors, so we can break if something is wrong
        ;We did not open our bank, so must open it
        bellCurveClick(bank_x1, bank_x2, bank_y1, bank_y2) ;Open our bank
        distributedRandSleep(900, 1200) ;Sleep between 1 to 1.5 ticks
      }
    }
  }
  return
}

arrowFletching(){
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  global arrow_fletch_choice
  guiDebug("Starting script: fletching " arrow_fletch_choice)
  distributedRandSleep(1500, 3000)
  global break_loop = 0
  global loop_errors = 0
  Loop {
    if (break_loop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
      break
      guiDebug("Failed to bank inventory 5 times, exiting script")
    }


    guiDebug("Rolling for antiban")
    antiban(5)
  }
  return
}

dartFletching(){
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  global dart_fletch_choice
  guiDebug("Starting script: fletching " dart_fletch_choice)
  distributedRandSleep(1500, 3000)
  global break_loop = 0
  global loop_errors = 0
  Loop {
    if (break_loop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    if (loop_errors = 5){ ;We've been messing up, exit script to not look like a bot
      break
      guiDebug("Failed to bank inventory 5 times, exiting script")
    }


    guiDebug("Rolling for antiban")
    antiban(1)
  }
  return
}
