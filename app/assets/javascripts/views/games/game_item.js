Dorkle.Views.GameItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-item',
  template: JST['games/_item'],

  render: function () {
    var renderedContent = this.template({
      game: this.model
    });
    this.$el.html(renderedContent);

    return this;
  }
})
