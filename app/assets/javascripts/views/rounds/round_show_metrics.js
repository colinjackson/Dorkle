Dorkle.Views.RoundShowMetrics = Backbone.View.extend({
  template: JST['rounds/_metrics'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
    this.listenTo(this.model.matches(), 'add', this.handleNewMatch);

    this.timerIntervalID = setInterval(function () {
      this.updateTimer();
    }.bind(this), 125);
  },

  render: function () {
    var renderedContent = this.template({
      round: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  updateTimer: function () {
    var newTime = Dorkle.Utils.timeString(this.model.timeRemaining())
    this.$('.round-metrics-timer > span.time').text(newTime);
  },

  handleNewMatch: function () {
    this.updateAnswersLeft();
    if (this.model.isWon()) clearInterval(this.timerIntervalID);
  },

  updateAnswersLeft: function () {
    this.$('.round-metrics-remaining > span.left')
      .text(this.model.answersLeft());
  }

});
