Dorkle.Views.GameAnswersIndex = Backbone.Superview.extend({
  template: JST['game_answers/index'],

  initialize: function () {
    this.listenTo(this.collection, 'add', this.addAnswer);
    this.listenTo(this.collection, 'remove', this.removeAnswer);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var view = this;
    this.collection.each(function (answer) {
      view.addAnswer(answer);
    });

    var answerNewSubview = new Dorkle.Views.GameAnswerNew({
      collection: this.collection
    });
    this.addSubview('div.game-answers-new', answerNewSubview);

    return this;
  },

  addAnswer: function (answer) {
    var subview = new Dorkle.Views.GameAnswerItem({
      model: answer
    });

    this.addSubview('ul.game-answers-list', subview);
  },

  removeAnswer: function (answer) {
    var removingSubview;
    _(this.subviews('ul.game-answers-list')).each(function (subview) {
      if (subview.model === answer) removingSubview = subview;
    });

    this.removeSubview('ul.game-answers-list', removingSubview);
  }
});
