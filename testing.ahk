bellCurveMove(dimension_x, dimension_y){ ;Attemps at creating standard deviation clicking
  ;This entire function will be used as a decent antiban. It's not very human
  ;for clicking on an object to be completely and utterly random.
  ;Usually we will gravitate towards the center of something.
  ;1/20 chance it's on the extreme edge (N+3 or N-3, 5%)
  ;6/20 chance it's on the normal edge (N+2 or N-2, 30%)
  ;13/20 chance it's within a normal range (N+1 or N-1, 65%)

  Random, random_number_x, 1, 20
  if(random_number = 1 or random_number = 20){
    Random, random_x, (dimension_x - dimension_x*.9), (dimension_x - dimension_x*.1)
  } else if (random number > 1 and random_number < 8){
    Random, random_x, (dimension_x - dimension_x*.7), (dimension_x - dimension_x*.3)
  } else {
    Random, random_x, (dimension_x - dimension_x*.65), (dimension_x - dimension_x*.35)
  }

  Random, random_number_y, 1, 20
  if(random_number = 1 or random_number = 20){
    Random, random_y, (dimension_y - dimension_y*.9), (dimension_y - dimension_y*.1)
  } else if (random number > 1 and random_number < 8){
    Random, random_y, (dimension_y - dimension_y*.7), (dimension_y - dimension_y*.3)
  } else {
    Random, random_y, (dimension_y - dimension_y*.65), (dimension_y - dimension_y*.35)
  }

  MouseMove, random_y, random_x

}
