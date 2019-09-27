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
; 9/26/2019  Alex Titus  https://github.com/alex-titus
; + Initial Push
; + First Attempts at creating
; =======================================================================================

; Global ================================================================================
#SingleInstance, Force ; Allow only one running instance of script
#Persistent ; Keep script permanently running until terminated
#Warn ; Enable warnings to assist with detecting common errors
SetWorkingDir, %A_ScriptDir% ; Change the working directory of the script
OnExit, ExitSub ; Run a subroutine or function automatically when the script exits
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
; =======================================================================================

; Script ================================================================================
Gui, Add, Button, w300 y20 gDoSomething, Start Fletching


Gui, Show, , Mobile OSRS AHK Bot
return ;End automatic execution
; =======================================================================================

; Labels ================================================================================
DoSomething:
  Click("oak_logs.png")
  RandSleep(43, 102)
  Click("knife.png")
  RandSleep(602, 1030)
  Send, 3

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

inventoryDrop(text){
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
		ImageSearch, output_x, output_y, move_temp_x, output_y, 1920, 1080, *40 %A_WorkingDir%\images\%text%
		;log("found at x:" output_x " y:" output_y) ;Logs current coords of the item
		items_in_row := items_in_row + 1
		Random, randX, 0, 35 ;Random x value increment for humanlike difference
		Random, randY, 0, 35 ;Random y value increment for humanlike difference
		tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
		tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
		MouseMove, tempX, tempY
		if (ErrorLevel = 0){ ;The item was found on screen
			Click
		}
		if (ErrorLevel = 1){ ;The item wasn't found on screen
			total_errors++
		}
		if (total_errors == 2){ ;If we haven't found the item in 2 times, exit
			break
		}

		if (items_in_row == 4){
      ;If we found 4 items in a row, go down and over to next row
			output_y := output_y + 40
			move_temp_x := output_x - 240
			items_in_row := 0
		} else {
      ;Start our search for next item 60 pixels greater than where the last was found
			move_temp_x := output_x + 60
    }
		RandSleep(85, 140)
		totalClicks++
	}
}

click(text){
  output_x = 0 ;ImageSearch will output x coordinates here
  output_y = 0 ;Imagesearch will output y coordinates here
  ImageSearch, output_x, output_y, 0, 0, 1920, 1080, *40 %A_WorkingDir%\images\%text%
  ;log("found at x:" output_x " y:" output_y) ;Logs current coords of the item
  Random, randX, -5, 15 ;Random x value increment for humanlike difference
  Random, randY, 0, 35 ;Random y value increment for humanlike difference
  tempX := output_x + randX ;Adds our random value to ImageSearch's found coords
  tempY := output_y + randY ;Adds our random value to ImageSearch's found coords
  MouseMove, tempX, tempY
  Click
}
; =======================================================================================
