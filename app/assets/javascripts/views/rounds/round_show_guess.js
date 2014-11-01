Dorkle.Views.RoundShowGuess = Backbone.View.extend({
  className: 'game-answers-guess',
  template: JST['rounds/_guess'],

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    return this;
  }
});
