Dorkle.Views.GameNew = Backbone.Superview.extend({
  template: JST['games/new'],

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    var newGame = new Dorkle.Models.Game({author_id: Dorkle.currentUserId});
    var formSubview = new Dorkle.Views.GameForm({
      model: newGame,
      buttonText: 'Get your game on!'
    });
    this.addSubview('div.game-add-new', formSubview);

    return this;
  }
});
