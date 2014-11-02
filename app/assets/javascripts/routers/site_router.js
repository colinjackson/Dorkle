Dorkle.Routers.SiteRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$mainEl = options.$mainEl;
  },

  routes: {
    '': 'gamesIndex',
    'games': 'gamesIndex',
    'games/new': 'gameNew',
    'games/:id': 'gameShow',
    'games/:game_id/round': 'roundShow'
  },

  gamesIndex: function () {
    var view = new Dorkle.Views.GamesIndex({
      collection: Dorkle.games
    });
    Dorkle.games.fetch();

    this._swapMainView(view);
  },

  gameNew: function () {
    var view = new Dorkle.Views.GameNew();
    this._swapMainView(view);
  },

  gameShow: function (id) {
    var game = Dorkle.games.getOrFetch(id);
    var view = new Dorkle.Views.GameShow({
      model: game
    });

    this._swapMainView(view);
  },

  roundShow: function (gameId) {
    var round = new Dorkle.Models.Round({game_id: gameId})
    var view = new Dorkle.Views.RoundShow({
      model: round
    });
    round.save();

    this._swapMainView(view);
  },

  _swapMainView: function (view) {
    this.$mainEl.empty();
    this.currentView && this.currentView.remove();
    this.$mainEl.html(view.render().$el);
    this.currentView = view;
  }
});
