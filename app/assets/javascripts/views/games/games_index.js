Dorkle.Views.GamesIndex = Backbone.Superview.extend({
  className: 'games-index',
  template: JST['games/index'],

  initialize: function (options) {
    this.listenTo(this.collection, 'add', this.addGame);
  },

  render: function () {
    var renderedContent = this.template()
    this.$el.html(renderedContent);

    var view = this;
    this.collection.each(function (game) {
      view.addGame(game);
    });

    return this;
  },

  addGame: function (game) {
    var subview = new Dorkle.Views.GameItem({
      model: game
    });
    this.addSubview('ul.games-list', subview);
  }

});
