Dorkle.Views.GameItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-item',
  template: JST['games/_item'],

  events: {
    "click a.game-show-link": "goToGame"
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  goToGame: function () {
    var gamePath = "/games/" + this.model.id;
    Backbone.history.navigate(gamePath, {trigger: true});
  }
});
