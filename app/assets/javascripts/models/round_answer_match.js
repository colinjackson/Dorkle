Dorkle.Models.RoundAnswerMatch = Backbone.Model.extend({
  initialize: function (options) {
    this.answer = options.answer;
    this.set({
      round_id: options.round.id,
      answer_id: options.answer.id
    });
  }
});
