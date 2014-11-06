Dorkle.Views.RoundShowGuess = Backbone.View.extend({
  className: 'round-show-board-guess',
  template: JST['rounds/_guess'],

  initialize: function (options) {
    this.validAnswers = options.validAnswers;
  },

  events: {
    'keypress #guess-box': 'handleEnter',
    'keyup #guess-box': 'checkAnswer',
    'submit': 'cancelSubmission'
  },

  cancelSubmission: function (event) { event.preventDefault(); },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    this.$guessBox = this.$('#guess-box');

    return this;
  },

  startRound: function () {
    this.$guessBox.prop('disabled', false);
    this.$guessBox.focus();
  },

  handleEnter: function (event) {
    if (event.which === 13) {
      this.$guessBox.addClass('incorrect-flash');

      setTimeout(function () {
        this.$guessBox.removeClass('incorrect-flash');
      }.bind(this), 500);
    }
  },

  checkAnswer: function (event) {
    var guess = this.$guessBox.val().toLowerCase();

    var matchingAnswers = this.validAnswers.answersForGuess(guess);
    if (matchingAnswers.length > 0) {
      this.handleCorrectGuess(matchingAnswers);
    }
  },

  handleCorrectGuess: function (answers) {
    this.$guessBox.val('');

    _(answers).each(function (answer) {
      var answerMatch = new Dorkle.Models.RoundAnswerMatch({
        answer: answer
      });
      answerMatch.set({round_id: this.model.id, answer_id: answer.id});
      this.model.matches().create(answerMatch);

      this.validAnswers.remove(answer);
    }.bind(this));
  },

  endRound: function () {
    this.$guessBox.prop('disabled', true);
  }

});
