Dorkle.Views.RoundShowStatus = Backbone.Superview.extend({
  className: 'round-show-board-status',
  template: JST['rounds/_status'],

  initialize: function (options) {
    this.validAnswers = options.validAnswers;
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

  addAnswerMatch: function (answerMatch, isMissed) {
    var subview = new Dorkle.Views.AnswerMatchItem({
      model: answerMatch,
      isMissed: (isMissed === true ? true : false)
    });

    this.addSubview('ul.board-status-matches-list', subview);
  },

  endRound: function () {
    this.stopListening();
    this.validAnswers.each(function (missedAnswer) {
      var missedMatch = new Dorkle.Models.RoundAnswerMatch({
        answer: missedAnswer
      });
      this.addAnswerMatch(missedMatch, true);
    }.bind(this));
  }

});
