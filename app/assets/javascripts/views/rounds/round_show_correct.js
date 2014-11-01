Dorkle.Views.RoundShowCorrect = Backbone.Superview.extend({
  className: 'game-answers-correct',
  template: JST['rounds/_correct'],

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    return this;
  }
})
