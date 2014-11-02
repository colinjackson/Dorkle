Dorkle.Views.GameForm = Backbone.View.extend({
  tagName: 'form',
  className: 'default',
  template: JST['games/_form'],

  initialize: function (options) {
    this.buttonText = options.buttonText;
  },

  events: {
    'click button.game-form-submit': 'saveGame'
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model,
      buttonText: this.buttonText
    });
    this.$el.html(renderedContent);

    return this;
  },

  saveGame: function (event) {
    event.preventDefault();

    this.model.set(this.$el.serializeJSON());
    this.model.save({}, {
      success: function (game) {
        Dorkle.games.add(game);
        var newGamePath = '/games/' + game.id;
        Backbone.history.navigate(newGamePath, {trigger: true});
      }
    });
  }
})
