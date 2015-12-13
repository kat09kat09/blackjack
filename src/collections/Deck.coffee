class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

    # @on('change', => 
    #   console.log('changeLength listener called')
    #   if not @length then trigger('reshuffle')
    # )
    

  dealPlayer: -> new Hand [@deal().flip(), @deal().flip()], @

  dealDealer: -> new Hand [@deal().flip(), @deal().flip()], @, true

  deal: ->
    console.log('length', @length)
    if @length < 26 
      console.log('reshuffle should not trigger unless length is LT 26')
      @trigger('reshuffle', @)
    @pop()


