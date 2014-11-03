Dorkle.Collections.RoundAnswerMatches = Backbone.Collection.extend({
  model: Dorkle.Models.RoundAnswerMatch,
  url: function () {
    return this.round.url() + '/round_answer_matches'
  },

  initialize: function (models, options) {
    this.round = options.round;
  }
});
