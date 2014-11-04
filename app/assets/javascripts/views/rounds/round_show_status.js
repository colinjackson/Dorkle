Dorkle.Views.RoundShowStatus = Backbone.Superview.extend({
  className: 'round-show-board-status',
  template: JST['rounds/_status'],

  initialize: function () {
    this.listenTo(this.model.matches(), 'add', this.addAnswerMatch);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var metricsSubview = new Dorkle.Views.RoundShowMetrics({
      model: this.model
    });
    this.addSubview('div.board-status-metrics', metricsSubview);

    var view = this;
    this.model.matches().each(function (answerMatch) {
      view.addAnswerMatch(answerMatch);
    });

    return this;
  },

  startRound: function () {
    this.subviews('div.board-status-metrics')[0].startRound();
  },

  addAnswerMatch: function (answerMatch) {
    var subview = new Dorkle.Views.AnswerMatchItem({
      model: answerMatch
    });

    this.addSubview('ul.board-status-matches-list', subview);
  },

  endRound: function () {
    this.subviews('div.board-status-metrics')[0].endRound();
  }

});
