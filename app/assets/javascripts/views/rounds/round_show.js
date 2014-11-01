Dorkle.Views.RoundShow = Backbone.Superview.extend({
  template: JST['rounds/show'],

  initialize: function () {
    this.listenTo(this.model, 'change', this.resetTitle);
  },

  render: function () {
    var renderedContent = this.template({
      round: this.model
    });
    this.$el.html(renderedContent);

    var guessSubview = new Dorkle.Views.RoundShowGuess();
    this.addSubview('.round-show', guessSubview);

    var correctSubview = new Dorkle.Views.RoundShowCorrect();
    this.addSubview('.round-show', correctSubview);

    return this;
  },

  resetTitle: function () {
    if (this.model.game) {
      this.$('h1').text(this.model.game.get('title'));
    }
  }

});
