Dorkle.Models.RoundAnswerMatch = Backbone.Model.extend({
  urlRoot: '/api/round_answer_matches',

  initialize: function (options) {
    if (options && options.answer) this._answer = options.answer;
  },

  answer: function () {
    if (!this._answer) {
      var answerId = this.get('answer_id');
      this._answer = this.collection.round.answers().get(answerId);
    }

    return this._answer;
  }
});
