Dorkle.Views.RoundShowGuess = Backbone.View.extend({
  className: 'game-answers-guess',
  template: JST['rounds/_guess'],

  initialize: function (options) {
    this.validAnswers = options.validAnswers;
  },

  events: {
    'keyup #guess-box': 'checkAnswer'
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    return this;
  },

  checkAnswer: function (event) {
    var $guessBox = $(event.currentTarget);
    var guess = $guessBox.val();

    var correctAnswer;
    this.validAnswers.every(function (answer) {
      if (guess === answer.get('answer')) {
        correctAnswer = answer;
        return false;
      }
      return true;
    });

    if (correctAnswer) this.handleCorrectGuess(correctAnswer, $guessBox);
  },

  handleCorrectGuess: function (answer, $guessBox) {
    var answerMatch = new Dorkle.Models.RoundAnswerMatch({
      round_id: this.model.id,
      answer_id: answer.id
    });

    this.model.matches().add(answerMatch);
    this.validAnswers.remove(answer);
    $guessBox.val('');
  }
});
