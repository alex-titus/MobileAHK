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
BreakLoop = 0 ;Used for breaking out of looping functions without exiting program
bank_x1 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_x2 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_y1 = 0 ;Global variable to use for where the bank is for different bankstanding activies
bank_y2 = 0 ;Global variable to use for where the bank is for different bankstanding activies
; =======================================================================================

; Script ================================================================================
findBluestacks() ;Find bluestacks so we know where to search for images
Gui, Add, Button, x2 y9 w150 h70 gFletching, Fletching
Gui, Add, Button, x2 y89 w150 h70 gTesting, Testing
Gui, Add, Button, x2 y169 w150 h70 , Magic
Gui, Add, Button, x2 y249 w150 h70 gHerbCleaning, Herb Cleaning
Gui, Add, DropDownList, x162 y9 w120 h21 , DropDownList
Gui, Add, DropDownList, x162 y89 w120 h21 , DropDownList
Gui, Add, DropDownList, x162 y169 w120 h21 , DropDownList
Gui, Add, DropDownList, x162 y249 w120 h21 , DropDownList

Gui, Show, , Mobile OSRS AHK Bot
return ;End automatic execution

F12::
  log("Breaking loop...")
  BreakLoop = 1
  return

ESC::
  ExitApp
; =======================================================================================

; Labels ================================================================================
HerbCleaning:
  global bank_x1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_x2 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y1 ;Global variable to use for where the bank is for different bankstanding activies
  global bank_y2 ;Global variable to use for where the bank is for different bankstanding activies
  askForBankCoords()
  distributedRandSleep(800, 1500)
  BreakLoop = 0
  Loop {
    if (BreakLoop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    inventoryClick("grimy_marrentil.png", 27, 21)
    RandSleep(243, 482)
    Random, random_bank_x, 576, 850
    Random, random_bank_y, 365, 645
    MouseClick, Left, random_bank_x, random_bank_y
    RandSleep(600, 993)
    click("bank_inventory.png", 55, 56)
    RandSleep(353, 454)
    click("grimy_marrentil.png", 27, 21)
    RandSleep(123, 193)
    click("bank_close.png", 34, 34)
    RandSleep(540, 745)
  }
  return

Testing:
  return

Fletching:
  Loop {
    if (BreakLoop = 1){ ;Used to break out of any function when pressing F12
      break
    }
    bank_x = 0
    bank_y = 0
    click("knife.png", 20, 20)
    RandSleep(243, 482)
    click("maple_logs.png", 32, 21)
    RandSleep(842, 1110)
    if (click("maple_longbow_u.png", 80, 96) == 0){
      RandSleep(47000, 57000)
    }
    Random, bank_x, 530, 380
    Random, bank_y, 830, 660
    MouseClick, Left, bank_x, bank_y
    MouseClick, Left, bank_x, bank_y
    RandSleep(900, 1113)
    if (click("bank_inventory.png", 55, 56) = 1){
      RandSleep(113, 254)
      click("maple_logs.png", 32, 21)
      RandSleep(123, 193)
      click("bank_close.png", 34, 34)
      RandSleep(340, 745)
    }
  }
  return


GuiEscape:
GuiClose:
ExitSub:
	ExitApp ;Exits the script completely
; =======================================================================================

; Functions =============================================================================
Log(text){ ;Allows for output of debug to Windows DebugView, filter using "AHK| "
	OutputDebug % "AHK| " text
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
  } else if (random > 50 and random <= 80){
    Random, random_sleep, average_sleep-(2*distribution_sleep), average_sleep+(2*distribution_sleep)
  } else if (random > 80){
    Random, random_sleep, average_sleep-(3*distribution_sleep), average_sleep+(3*distribution_sleep)
  } else {
    Random, random_sleep, average_sleep-(4*distribution_sleep), average_sleep+(4*distribution_sleep)
  }
  Sleep %random_sleep%
}

findBluestacks(){
  global bluestacks_top_left_x = 0 ;ImageSearch will output x coordinats of top left corner of bluestacks here
  global bluestacks_top_left_y = 0 ;Imagesearch will output y coordinate of top left corner of bluestacks here
  global bluestacks_bottom_right_x = 0 ;ImageSearch will output x coordinate of bottom right corner of bluestacks here
  global bluestacks_bottom_right_y = 0 ;Imagesearch will output y coordinate of bottom right corner of bluestacks here

  log("Searching for bluestacks...")

  ImageSearch, bluestacks_top_left_x, bluestacks_top_left_y, 0, 0, 1920, 1080, *20 %A_WorkingDir%\images\bluestacks_icon.png
  if (ErrorLevel = 0){
    log("Top left of bluestacks found at x:" bluestacks_top_left_x " y:" bluestacks_top_left_y) ;Logs coordinates of top left corner of bank
  } else if (ErrorLevel = 1){
    log("Unable to find top left corner of the bluestacks...")
  }

  ImageSearch, bluestacks_bottom_right_x, bluestacks_bottom_right_y, 0, 0, 1920, 1080, *20 %A_WorkingDir%\images\bluestacks_back.png
  if (ErrorLevel = 0){
    log("Bottom right of bank found at x:" bluestacks_bottom_right_x " y:" bluestacks_bottom_right_y) ;Logs coordinates of bottom right corner of bank
  } else if (ErrorLevel = 1){
    log("Unable to find top left corner of the bluestacks...")
  } ;Allows us to find Bluestacks, no real use yet tho
}

inventoryClick(image, size_x, size_y){
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
		ImageSearch, output_x, output_y, move_temp_x, output_y, 1920, 1080, *TransRed *45 %A_WorkingDir%\images\%image%
		log("found at x:" output_x " y:" output_y) ;Logs current coords of the item
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
      log("Wasn't found on scren")
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

click(image, size_x, size_y){
  output_x = 0 ;ImageSearch will output x coordinates here
  output_y = 0 ;Imagesearch will output y coordinates here
  ImageSearch, output_x, output_y, 0, 0, 1920, 1080, *TransRed *45 %A_WorkingDir%\images\%image%
  if(ErrorLevel = 0){
    log("found at x:" output_x " y:" output_y) ;Logs current coords of the item
    Random, randX, 3, size_x - 2 ;Random x value increment for humanlike difference
    Random, randY, 3, size_y - 2 ;Random y value increment for humanlike difference
    tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
    tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
    MouseMove, tempX, tempY
    Click
    return 0
  } else if (ErrorLevel = 1){
    log(image " not found")
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

  log("Searching for bank...")

  ImageSearch, bank_top_left_x, bank_top_left_y, bluestacks_top_left_x, bluestacks_top_left_y, bluestacks_bottom_right_x, bluestacks_bottom_right_y, *50 %A_WorkingDir%\images\top_left_corner_bank.png
  if (ErrorLevel = 0){
    log("Top left of bank found at x:" bank_top_left_x " y:" bank_top_left_y) ;Logs coordinates of top left corner of bank
  } else if (ErrorLevel = 1){
    log("Unable to find top left corner of the bank...")
  }

  ImageSearch, bank_bottom_right_x, bank_bottom_right_y, bluestacks_top_left_x, bluestacks_top_left_y, bluestacks_bottom_right_x, bluestacks_bottom_right_y, *50 %A_WorkingDir%\images\bank_equipment.png
  if (ErrorLevel = 0){
    log("Bottom right of bank found at x:" bank_bottom_right_x " y:" bank_bottom_right_y) ;Logs coordinates of bottom right corner of bank
  } else if (ErrorLevel = 1){
    log("Unable to find bottom right corner of the bank...")
  }

  ImageSearch, item_coordinate_x, item_coordinate_y, bank_top_left_x, bank_top_left_y, bank_bottom_right_x, bank_bottom_right_y, *40 %A_WorkingDir%\images\%item%
  if (ErrorLevel = 0){
    log("Item found at x:" item_coordinate_x " y:" item_coordinate_y) ;Logs coordinates of bottom right corner of bank
    return 0
  } else if (ErrorLevel = 1){
    log("Unable to find item in the bank...")
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
      if(antiban_activity >= 0){
        distributedRandSleep(13000, 25000)
        log("Sleeping between 13 and 25 seconds")
      } else if (antiban_activity >= 50){
        distributedRandSleep(20000, 45000)
        log("Sleeping between 20 and 45 seconds")
      }
    }
}


; =======================================================================================
