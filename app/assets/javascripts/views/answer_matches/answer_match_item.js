Dorkle.Views.AnswerMatchItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-answer-item group',
  template: JST['answer_matches/_item'],

  initialize: function (options) {
    this.isMissed = options.isMissed;
  },

  render: function () {
    var renderedContent = this.template({
      answerMatch: this.model,
    });
    this.$el.html(renderedContent);
    if (this.isMissed) this.$el.addClass('missed');

    return this;
  }
})
