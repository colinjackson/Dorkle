Dorkle.Collections.GameAnswers = Backbone.Collection.extend({
  model: Dorkle.Models.GameAnswer,
  url: function () {
    return this.game.url() + '/game_answers';
  },

  initialize: function (options) {
    this.game = options.game;
  }
});
