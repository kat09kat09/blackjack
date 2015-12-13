# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'chips', 1000
    @set 'bet', 20
    @reshuffle()
    @newHand()

    

  endHand: -> 
    @dealerPlays()
    playerScore= window.getHighScore(@get('playerHand').scores())
    dealerScore= window.getHighScore(@get('dealerHand').scores())
    console.log("App.endHand called. playerScore: #{playerScore}, dealerScore: #{dealerScore}")

    if playerScore is dealerScore 
      console.log('tie fxn gets called')
      @tie()
    else if playerScore > dealerScore
      @win()
    else if playerScore < dealerScore 
      @lose()

    console.log('should be true only if LT 26', @get 'reshuffle')
    if @get 'reshuffle' 
      alert('Reshuffled the the deck')
      @reshuffle()

    @newHand()

 
  dealerPlays: ->
    @get('dealerHand').first().flip()
    `
    while (window.getHighScore(this.get('dealerHand').scores()) < 17 &&
          window.getHighScore(this.get('dealerHand').scores()) !== 0 &&
          window.getHighScore(this.get('playerHand').scores()) !== 0) {
      this.get('dealerHand').hit()
    }
    `
    true


    #stay if at 17 or higher
    #hit if below that
    # if over 21 end game 
    #i21 

  reshuffle: ->
    @set 'deck', deck = new Deck()
    @set 'reshuffle', false
    @get('deck').on('reshuffle', =>
      console.log ('App heard a reshuffle!')
      @set 'reshuffle', true
    )
        

  newHand: ->
    console.log('newHand gets called'); 
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

    # if window.getHighScore(@get('playerHand').scores()) is 21 or window.getHighScore(@get('dealerHand').scores()) is 21 
    #   #natural blackjack
    #   @endHand()
      
    @get('playerHand').on('stand', =>
      console.log('App heard playerHand stand')
      @endHand()
    )
    @trigger('newHand', @)

  tie: ->
    console.log('App.tie called')
    alert('You tied!')

  win: ->
    console.log('App.win called')
    @set('chips', parseInt(@get('chips'),10) + parseInt(@get('bet'),10))
    alert('You won!')

  lose: ->  
    console.log('App.lose called')
    @set('chips', parseInt(@get('chips'),10) - parseInt(@get('bet'),10))
    alert('You lose!')

 
