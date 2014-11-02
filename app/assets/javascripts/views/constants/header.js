Dorkle.Views.Header = Backbone.View.extend({

  events: {
    'click a.go-to': 'preventDefault',
    'click a.go-to.root': 'goToRoot',
    'click a.go-to.current-user': 'goToCurrentUser',
    'click a.go-to.games': 'goToGames',
    'click a.go-to.create': 'goToCreate',
    'click a.go-to.random-game': 'goToRandomGame'
  },
  preventDefault: function (event) { event.preventDefault(); },

  goToRoot: function () {
    Backbone.history.navigate('', {trigger: true});
  },

  goToCurrentUser: function () {
    currentUserPath = 'users/' + Dorkle.currentUserId;
    Backbone.history.navigate(currentUserPath, {trigger: true});
  },

  goToGames: function () {
    Backbone.history.navigate('games', {trigger: true});
  },

  goToCreate: function () {
    Backbone.history.navigate('games/new', {trigger: true});
  },

  goToRandomGame: function () {
    Dorkle.games.fetch({
      success: function () {
        var randomGameId = Math.floor(Math.random() * Dorkle.games.length) + 1;
        var randomGamePath = 'games/' + randomGameId;
        Backbone.history.navigate(randomGamePath, {trigger: true});
      }
    });
  }

});
