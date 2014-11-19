Dorkle.Views.RoundShowMetrics = Backbone.View.extend({
  className: 'round-show-metrics',
  template: JST['rounds/_metrics'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render)
    this.listenTo(this.model.matches(), 'add', this.updateAnswersLeft);
  },

  events: {
    'click .give-up': 'roundCompleted'
  },

  render: function () {
    var renderedContent = this.template({
      round: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  startRound: function () {
    this.timerIntervalID = setInterval(function () {
      this.updateTimer();
    }.bind(this), 125);
  },

  updateTimer: function () {
    var newTime = Dorkle.Utils.timeString(this.model.timeRemaining())
    this.$('.round-metrics-timer > span.time').text(newTime);
  },

  updateAnswersLeft: function () {
    this.$('.round-metrics-remaining > span.left')
      .text(this.model.answersLeft());
  },

  roundCompleted: function () {
    this.model.set('is_completed', true);
    this.model.save();
  },

  endRound: function () {
    clearInterval(this.timerIntervalID);
  },

  remove: function () {
    if (this.timerIntervalID) clearInterval(this.timerIntervalID);
    Backbone.View.prototype.remove.call(this);
  }

});
