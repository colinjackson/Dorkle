Dorkle.Views.RoundShow = Backbone.Superview.extend({
  template: JST['rounds/show'],

  initialize: function () {
    this.listenToOnce(this.model, 'sync', this.prepareForStart);

    this.validAnswers = this.model.answers().clone();
    this.listenTo(this.model.answers(), 'add', this.updateValidAnswers);
    this.listenTo(this.validAnswers, 'remove', this.checkForVictory);
  },

  render: function () {
    var renderedContent = this.template({
      round: this.model
    });
    this.$el.html(renderedContent);

    var guessSubview = new Dorkle.Views.RoundShowGuess({
      model: this.model,
      validAnswers: this.validAnswers
    });
    this.addSubview('.round-show', guessSubview);

    var correctSubview = new Dorkle.Views.RoundShowStatus({
      model: this.model
    });
    this.addSubview('.round-show', correctSubview);

    return this;
  },

  prepareForStart: function () {
    this.$('h1').text(this.model.game.get('title'));

    if (!this.model.get('start_time')) {
      setTimeout(this.startRound.bind(this), 1000);
    } else if (this.model.timeRemaining() > 0) {
      this.startRound();
    }
  },

  startRound: function () {
    var timeLimit;
    if (!this.model.get('start_time')) {
      this.model.set('start_time', new Date());
      this.model.save();
    }

    timeLimit = this.model.timeRemaining() * 1000;
    this.roundTimeoutID = setTimeout(this.handleDefeat.bind(this), timeLimit);

    this._subviewsSend(function (subview) {
      subview.startRound();
    });
  },

  updateValidAnswers: function (newAnswer) {
    this.validAnswers.add(newAnswer);
  },

  checkForVictory: function () {
    if (this.model.isWon()) this.handleVictory();
  },

  handleVictory: function () {
    this.endRound();
    alert('Congratulations! You win!')
  },

  handleDefeat: function () {
    this.endRound();
    alert('Oh no, you lose!');
  },

  endRound: function () {
    clearInterval(this.roundTimeoutID)
    this._subviewsSend(function (subview) {
      subview.endRound();
    });
    this.model.save();
  },

  remove: function () {
    if (this.roundTimeoutID) clearInterval(this.roundTimeoutID);
    Backbone.Superview.prototype.remove.call(this);
  },

  _subviewsSend: function (callback) {
    _(this.subviews()).each(function (subviews) {
      _(subviews).each(function (subview) {
        callback(subview);
      });
    });
  }

});
