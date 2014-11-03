Dorkle.Routers.SiteRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$mainEl = options.$mainEl;
  },

  routes: {
    '': 'gamesIndex',
    'games': 'gamesIndex',
    'games/new': 'gameNew',
    'games/:id': 'gameShow',
    'games/:game_id/round': 'roundCreate',
    'rounds/:id': 'roundShow'
  },

  gamesIndex: function () {
    var view = new Dorkle.Views.GamesIndex({
      collection: Dorkle.games
    });
    Dorkle.games.fetch();

    this._swapMainView(view);
  },

  gameNew: function () {
    if (Dorkle.currentUserId) {
      var view = new Dorkle.Views.GameNew();
      this._swapMainView(view);
    } else {
      Backbone.history.navigate('', {trigger: true});
    }
  },

  gameShow: function (id) {
    var game = Dorkle.games.getOrFetch(id);
    var view = new Dorkle.Views.GameShow({
      model: game
    });

    this._swapMainView(view);
  },

  roundCreate: function (gameId) {
    var round = new Dorkle.Models.Round({game_id: gameId})
    var view = new Dorkle.Views.RoundShow({
      model: round
    });
    round.save({}, {
      success: function () {
        var roundShowPath = '/rounds/' + round.id;
        Backbone.history.navigate(roundShowPath);
      }
    });

    this._swapMainView(view);
  },

  roundShow: function (id) {
    var round = new Dorkle.Models.Round({id: id});
    var view = new Dorkle.Views.RoundShow({
      model: round
    });
    round.fetch();

    this._swapMainView(view);
  },

  _swapMainView: function (view) {
    this.$mainEl.empty();
    this.currentView && this.currentView.remove();
    this.$mainEl.html(view.render().$el);
    this.currentView = view;
  }
});
