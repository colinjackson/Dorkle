Dorkle.Routers.SiteRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$mainEl = options.$mainEl;
    this.$mainEl.empty();
  },

  routes: {
    "": "gamesIndex"
  },

  gamesIndex: function () {
    var view = new Dorkle.Views.GamesIndex({
      collection: Dorkle.games
    });
    Dorkle.games.fetch();

    this._swapMainView(view);
  },

  _swapMainView: function (view) {
    this.currentView && this.currentView.remove();
    this.$mainEl.html(view.render().$el);
    this.currentView = view;
  }
})
