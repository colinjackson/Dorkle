Dorkle.Routers.SiteRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$mainEl = options.$mainEl;
    this.$mainEl.empty();
  },

  routes: {
    "": "gamesIndex",
    "games": "gamesIndex",
    "games/:id": "gameShow"
  },

  gamesIndex: function () {
    var view = new Dorkle.Views.GamesIndex({
      collection: Dorkle.games
    });
    Dorkle.games.fetch();

    this._swapMainView(view);
  },

  gameShow: function (id) {
    var game = Dorkle.games.getOrFetch(id);
    var view = new Dorkle.Views.GameShow({
      model: game
    });
    game.fetch();

    this._swapMainView(view);
  },

  _swapMainView: function (view) {
    this.currentView && this.currentView.remove();
    this.$mainEl.html(view.render().$el);
    this.currentView = view;
  }
});
