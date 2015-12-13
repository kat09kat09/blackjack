class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button" disabled>Hit</button> <button class="stand-button" disabled>Stand</button>
    <input class="bet" value="<%= bet %>"></input>
    <button class="submit-bet">Submit</button>
    <span class="chips">Chipstack: <%=chips%></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      console.log('AppView heard stand click')
      @model.get('playerHand').stand()
    'click .submit-bet': ->
      @sumbitBet()
      

  sumbitBet: ->
    @model.set('bet', $('.bet').val())
    $('.bet').attr('disabled', true) 
    $('.hit-button').attr('disabled', false) 
    $('.stand-button').attr('disabled', false) 
    @model.get('playerHand').at(0).flip()
    @model.get('playerHand').at(1).flip()
    @model.get('dealerHand').at(1).flip()
    console.log(@model.get('bet'))

  initialize: ->
    @render()
    @model.on('newHand', =>
      @render()
      console.log('AppView heard newHand')
      )

  render: ->
    @$el.children().detach()
    @$el.html @template(@model.attributes)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

