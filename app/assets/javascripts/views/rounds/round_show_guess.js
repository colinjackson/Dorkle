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
        this.$guessBox.addClass('will-transition');
        this.$guessBox.removeClass('incorrect-flash');
        setTimeout(function () {
          this.$guessBox.removeClass('will-transition');
        }.bind(this), 500);
      }.bind(this), 125);
    }
  },

  checkAnswer: function (event) {
    var guess = this.$guessBox.val().toLowerCase();

    var correctAnswer;
    this.validAnswers.every(function (answer) {
      if (guess === answer.get('answer').toLowerCase()) {
        correctAnswer = answer;
        return false;
      }
      return true;
    });

    if (correctAnswer) this.handleCorrectGuess(correctAnswer, this.$guessBox);
  },

  handleCorrectGuess: function (answer) {
    this.$guessBox.val('');

    var answerMatch = new Dorkle.Models.RoundAnswerMatch({
      answer: answer
    });
    answerMatch.set({round_id: this.model.id, answer_id: answer.id});
    this.model.matches().create(answerMatch);

    this.validAnswers.remove(answer);
  },

  endRound: function () {
    this.$guessBox.prop('disabled', true);
  }

});
