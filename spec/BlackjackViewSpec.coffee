describe 'BlackJack App', ->
  app = null

  beforeEach ->
    app = new App()
    sinon.spy(app, 'tie')
    sinon.spy(app, 'win')
    sinon.spy(app, 'lose')
    sinon.spy(app, 'endHand')

  afterEach ->
    app.tie.restore()
    app.win.restore()
    app.lose.restore()
    app.endHand.restore()

  describe 'dealer', ->
    it 'dealer card gets flipped when stand is clicked', ->
      app.get('playerHand').stand()
      assert.strictEqual app.get('dealerHand').first().get('revealed'), true

  describe 'outcomes', ->
    it 'will call the tie function when the dealer score equals the player score', ->
      app.set('playerHand', new Hand([new Card(rank:10, suit:0)]))
      app.set('dealerHand', new Hand([new Card(rank:10, suit:0)]))
      debugger
      app.get('playerHand').stand()
      console.log(app.get('playerHand'), app.get('dealerHand'))
      expect(app.tie).to.have.been.called()

    it 'will call the win function when the dealer score equals the player score', ->
      app.set('playerHand', new Hand([new Card(rank:10, suit:0)]))
      app.set('dealerHand', new Hand([new Card(rank:5, suit:0)]))
      app.get('playerHand').stand()
      expect(app.win).to.have.been.called()

    it 'will call the win function when the dealer score equals the player score', ->
      app.set('playerHand', new Hand([new Card(rank:5, suit:0)]))
      app.set('dealerHand', new Hand([new Card(rank:10, suit:0)]))
      app.get('playerHand').stand()
      expect(app.lose).to.have.been.called()

  describe 'when player busts, the game should end', ->
    it 'should call end hand', ->
      for num in [1..5] 
        app.get('playerHand').hit(); 

      expect(app.endHand).to.have.been.called()
      expect(app.lose).to.have.been.called()  

  describe 'when the game ends, there should be an auto refresh', ->
    it 'should reset the player hand to 2 cards', ->
      for num in [1..5] 
        app.get('playerHand').hit(); 
      assert.strictEqual app.get('playerHand').length, 2

  describe 'handles natural blackjack', ->
    it 'should end the game, if the player has natural blackjack', ->
      app.set('playerHand', new Hand([new Card(rank:10, suit:0), new Card(rank:1, suit:0)]))
      app.get('deck').dealPlayer()
      expect(app.endHand).to.have.been.called()
      expect(app.win).to.have.been.called()

    it 'should end the game, if the dealer has natural blackjack', ->
      app.set('dealerHand', new Hand([new Card(rank:10, suit:0), new Card(rank:1, suit:0)]))
      app.set('playerHand', new Hand([new Card(rank:5, suit:0), new Card(rank:5, suit:0)]))
      app.get('deck').dealPlayer()
      expect(app.lose).to.have.been.called()
      expect(app.endHand).to.have.been.called()

  describe 'dealer behavior', ->
    it 'should play hand on stand', ->
      sinon.spy(app.get('dealerHand'), 'stand')
      app.get('playerHand').stand();
      expect(app.get('dealerHand').stand).to.have.been.called()
      app.get('dealerHand').stand.restore()

  describe 'chip counts', ->
    it 'should have a chip count', ->
      expect(app.get('playerChipCount')).to.exist
    it 'should have a bet property', ->
      expect(app.get('playerBet')).to.exist

  describe 'deck status', ->
    it 'should shuffle the deck when the deck is empty', ->
      for num in app.get('deck')
        app.get('deck').pop()
      expect(app.get('deck').length).to.equal(52)


#TODO

#when player has natural blackjack, game shoudl automatically end
#when dealer has natural blackjack, game should automatically end
#dealer needs to play hand on stand

#Track chip counts
#Display chip counts
#Allow user to change bets


#2) Use the same shuffled deck across rounds

#1) Casino chips implementation

#3) Core blackJack Rules/Betting
#you bet, (before things get dealt)
  #if win
    #get double chips
  #if lose
    #lose what you put down

#double down
  #get one more card
  #double your bet

#splitting
  #doubles (cards of the same value)
  #split the card 
    #double your bet
    #2 hands 
      #played as if they were individual hands

#insurance -- skip 
  #dealer shows 10/Ace
  #before they reveal, 
  #put down chips 