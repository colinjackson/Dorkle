Dorkle.Views.GameItem = Backbone.View.extend({
  tagName: 'li',
  className: 'searchable-item game-item',
  template: JST['games/_item'],

  events: {
    'click a.game-show-link': 'goToGame'
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  goToGame: function () {
    var gameShowPath = '/games/' + this.model.id;
    Backbone.history.navigate(gameShowPath, {trigger: true});
  }
});
