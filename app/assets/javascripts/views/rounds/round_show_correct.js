Dorkle.Views.RoundShowCorrect = Backbone.Superview.extend({
  className: 'game-answers-correct',
  template: JST['rounds/_correct'],

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addAnswerMatch);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var view = this;
    this.collection.each(function (answerMatch) {
      view.addAnswerMatch(answerMatch);
    });

    return this;
  },

  addAnswerMatch: function (answerMatch) {
    var subview = new Dorkle.Views.AnswerMatchItem({
      model: answerMatch
    });

    this.addSubview('ul.game-answers-correct-list', subview);
  }
})
