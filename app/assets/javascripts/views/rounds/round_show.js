Dorkle.Views.RoundShow = Backbone.Superview.extend({
  template: JST['rounds/show'],

  initialize: function () {
    this.listenTo(this.model, 'change', this.resetTitle);

    this.validAnswers = this.model.answers().clone();
    this.listenTo(this.model.answers(), 'add', this.updateValidAnswers);
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

    var correctSubview = new Dorkle.Views.RoundShowCorrect({
      collection: this.model.matches()
    });
    this.addSubview('.round-show', correctSubview);

    return this;
  },

  resetTitle: function () {
    if (this.model.game) {
      this.$('h1').text(this.model.game.get('title'));
    }
  },

  updateValidAnswers: function (newAnswer) {
    this.validAnswers.add(newAnswer);
  }

});
