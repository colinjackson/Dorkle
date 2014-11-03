Dorkle.Views.GameNew = Backbone.Superview.extend({
  template: JST['games/new'],

  events: {
    'click button.game-form-submit': 'saveGame'
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    this.newGame = new Dorkle.Models.Game();
    var formSubview = new Dorkle.Views.GameForm({
      model: this.newGame
    });
    this.addSubview('div.game-add-new', formSubview);

    this.gameAnswers = new Dorkle.Collections.GameAnswers([], {
      game: this.newGame
    });
    var answersSubview = new Dorkle.Views.GameAnswersIndex({
      collection: this.gameAnswers
    });
    this.addSubview('div.game-answers', answersSubview);

    return this;
  },

  saveGame: function (event) {
    event.preventDefault();

    var newGameAttrs = this.$('div.game-add-new > form').serializeJSON();
    this.newGame.set(newGameAttrs);
    this.newGame.set('answers', this.gameAnswers);

    this.newGame.save({}, {
      success: function (game) {
        Dorkle.games.add(game);
        var newGamePath = '/games/' + game.id;
        Backbone.history.navigate(newGamePath, {trigger: true});
      }
    });
  }
});
