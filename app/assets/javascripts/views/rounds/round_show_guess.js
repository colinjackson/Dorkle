Dorkle.Views.RoundShowGuess = Backbone.View.extend({
  className: 'game-answers-guess',
  template: JST['rounds/_guess'],

  initialize: function (options) {
    this.validAnswers = options.validAnswers;
  },

  events: {
    'keyup #guess-box': 'checkAnswer',
    'submit': 'cancelSubmission'
  },

  cancelSubmission: function (event) { event.preventDefault(); },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    this.$guessBox = $('#guess-box');

    return this;
  },

  startRound: function () {
    this.$('label[for=guess-box]').text('Guess!')
    this.$guessBox.prop('disabled', false);
    this.$guessBox.focus();
  },

  checkAnswer: function (event) {
    var guess = this.$guessBox.val();

    var correctAnswer;
    this.validAnswers.every(function (answer) {
      if (guess === answer.get('answer')) {
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
      round: this.model,
      answer: answer
    });
    this.model.matches().add(answerMatch);

    this.validAnswers.remove(answer);
  },

  endRound: function () {
    this.$guessBox.prop('disabled', true);
  }

});
