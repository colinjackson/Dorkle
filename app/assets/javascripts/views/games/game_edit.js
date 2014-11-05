Dorkle.Views.GameEdit = Backbone.Superview.extend({
  className: 'game-edit',
  template: JST['games/edit'],

  events: {
    'click button.game-form-submit': 'saveGame',
    'click a.game-edit-return': 'returnToShow'
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var formSubview = new Dorkle.Views.GameForm({
      model: this.model
    });
    this.addSubview('.game-editing', formSubview);

    var gameAnswers = new Dorkle.Collections.GameAnswers([], {
      game: this.model
    });
    var answersSubview = new Dorkle.Views.GameAnswersIndex({
      collection: gameAnswers
    });
    gameAnswers.fetch();
    this.addSubview('.game-answers', answersSubview);

    return this;
  },

  saveGame: function (event) {
    event.preventDefault();

    var updatedGameAttrs = this.$('.game-editing > form').serializeJSON();
    this.model.set(updatedGameAttrs);

    this.model.save({}, {
      success: function (game) {
        var updatedGamePath = '/games/' + game.id;
        Backbone.history.navigate(updatedGamePath, {trigger: true});
        Dorkle.flash.displaySuccess('Changes successfully saved. Nice!');
      },
      error: function (game, response) {
        var message = "Oh no, your changes weren't saved! " + response.error;
        Dorkle.flash.displayError(message);
      }
    });
  },

  returnToShow: function (event) {
    event.preventDefault();

    var showGamePath = '/games/' + this.model.id;
    Backbone.history.navigate(showGamePath, {trigger: true});
  }
})
