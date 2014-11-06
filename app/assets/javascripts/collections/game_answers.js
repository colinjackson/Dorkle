Dorkle.Collections.GameAnswers = Backbone.Collection.extend({
  model: Dorkle.Models.GameAnswer,
  url: function () {
    return this.game.url() + '/game_answers';
  },

  initialize: function (models, options) {
    if (options && options.game) this.game = options.game;
  },

  answersForGuess: function (guess) {
    var matches = [];
    this.each(function (answer) {
      if (answer.doesMatch(guess)) matches.push(answer);
    });

    return matches;
  }
});
