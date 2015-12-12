assert = chai.assert

describe 'BlackJack App', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'dealer', ->
    it 'dealer card gets flipped when stand is clicked', ->
      app.get('playerHand').stand()
      assert.strictEqual app.get('dealerHand').first().get('revealed'), true