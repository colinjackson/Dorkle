Dorkle.Views.RoundShow = Backbone.Superview.extend({
  className: 'round-show',
  template: JST['rounds/show'],

  initialize: function () {
    this.listenToOnce(this.model, 'sync', this.prepareForStart);
    this.listenTo(this.model, 'change:is_completed', this.endRound);

    this.validAnswers = this.model.answers().clone();
    this.listenTo(this.model, 'sync', this.setValidAnswers)
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
    this.addSubview('.round-show-board-guessing', guessSubview);

    var metricsSubview = new Dorkle.Views.RoundShowMetrics({
      model: this.model
    });
    this.addSubview('.round-show-board-guessing', metricsSubview);

    var statusSubview = new Dorkle.Views.RoundShowStatus({
      model: this.model
    });
    this.addSubview('.round-show-board', statusSubview);

    return this;
  },

  prepareForStart: function () {
    this.$('h1').text(this.model.game.get('title'));

    if (!this.model.get('start_time')) {
      this.readySetGuess();
    } else if (this.model.timeRemaining() > 0 && !this.model.isWon()) {
      this.startRound();
    } else {
      this._setLabelState('game-over-state', 'GAME OVER!');
    }
  },

  readySetGuess: function () {
    setTimeout(function () {
      this._setLabelState('set-state', 'Set...');
      setTimeout(this.startRound.bind(this), 1000);
    }.bind(this), 1000);
  },

  startRound: function () {
    var timeLimit;
    if (!this.model.get('start_time')) {
      this.model.set('start_time', new Date());
      this.model.save();
    }

    this._setLabelState('go-state', 'Guess!');

    timeLimit = this.model.timeRemaining() * 1000;
    this.roundTimeoutID = setTimeout(this.handleDefeat.bind(this), timeLimit);

    this._subviewsSend(function (subview) {
      subview.startRound();
    });
  },

  setValidAnswers: function () {
    this.validAnswers.set(this.model.validAnswers().models);
  },

  checkForVictory: function () {
    if (this.model.isWon()) this.handleVictory();
  },

  handleVictory: function () {
    this.model.set('is_completed', true);
    this.model.save();
    alert('Congratulations! You win!')
  },

  handleDefeat: function () {
    this.model.set('is_completed', true);
    this.model.save();
    alert('Oh no, you lose!');
  },

  endRound: function () {
    if (!this.model.get('is_completed')) return false;
    this._setLabelState('game-over-state', 'GAME OVER!');

    clearInterval(this.roundTimeoutID)
    this._subviewsSend(function (subview) {
      subview.endRound();
    });
  },

  remove: function () {
    if (this.roundTimeoutID) clearInterval(this.roundTimeoutID);
    Backbone.Superview.prototype.remove.call(this);
  },

  _setLabelState: function (newState, text) {
    var states = ['ready-state', 'set-state', 'go-state', 'game-over-state'];
    var newStateIndex = states.indexOf(newState);
    states.splice(newStateIndex, 1);

    var $label = this.$('label[for=guess-box]');
    $label.text(text);
    $label.removeClass(states.join(' '));
    setTimeout(function () {
      $label.addClass(newState);
    }, 0);
  },

  _subviewsSend: function (callback) {
    _(this.subviews()).each(function (subviews) {
      _(subviews).each(function (subview) {
        callback(subview);
      });
    });
  }

});
