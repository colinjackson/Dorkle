Dorkle.Views.RoundShowStatus = Backbone.Superview.extend({
  className: 'round-show-board-status',
  template: JST['rounds/_status'],

  initialize: function () {
    this.listenTo(this.model.matches(), 'add', this.addAnswerMatch);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var view = this;
    this.model.matches().each(function (answerMatch) {
      view.addAnswerMatch(answerMatch);
    });

    return this;
  },

  startRound: function () { return true },

  addAnswerMatch: function (answerMatch) {
    var subview = new Dorkle.Views.AnswerMatchItem({
      model: answerMatch
    });

    this.addSubview('ul.board-status-matches-list', subview);
  },

  endRound: function () { return true }

});
