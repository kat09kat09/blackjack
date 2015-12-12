# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('stand', =>
      console.log('listener heard event')
      @endHand()
      )

  endHand: -> 
    @get('dealerHand').first().flip()
    playerScore= @getHighScore(@get('playerHand').scores())
    dealerScore= @getHighScore(@get('dealerHand').scores())
    console.log("Your score: #{playerScore} --- Dealer score: #{dealerScore}")

    if playerScore > dealerScore then alert('You Win!') else alert('You Lose!')
    
    

  getHighScore: (scores) -> 
    idealScore = 0

    for number in scores
      if number <= 21 and number > idealScore then idealScore = number
    idealScore
