F12::
  Loop {
    bellCurveClick(145, 639, 328, 763)
    Random, randX, 706, 1200
    Random, randY, 330, 765
    MouseClick, Left, randX, randY
    humanClick(1251, 1746, 323, 756)
  }
  return

ESC::
  ExitApp
  return

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
