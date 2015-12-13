window.getHighScore = (scores) -> 
  idealScore = 0

  for number in scores
    if number <= 21 and number > idealScore then idealScore = number
  idealScore

new AppView(model: new App()).$el.appendTo 'body'