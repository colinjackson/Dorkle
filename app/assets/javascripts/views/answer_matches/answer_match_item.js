Dorkle.Views.AnswerMatchItem = Backbone.View.extend({
  tagName: 'li',
  className: 'group',
  template: JST['answer_matches/_item'],

  render: function () {
    var renderedContent = this.template({
      answerMatch: this.model
    });
    this.$el.html(renderedContent);

    return this;
  }
})
