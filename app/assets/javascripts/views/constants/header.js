Dorkle.Views.Header = Backbone.View.extend({

  initialize: function () {
    this.barrelsRolled = 0;
  },

  events: {
    'click a.go-to': 'preventDefault',
    'click a.go-to.root': 'goToRoot',
    'click a.go-to.current-user': 'goToCurrentUser',
    'click a.go-to.games': 'goToGames',
    'click a.go-to.create': 'goToCreate',
    'click a.go-to.random-game': 'goToRandomGame',
    'mouseover img.dorkle-logo': 'doABarrelRoll'
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
    Dorkle.siteRouter.gameNew();
  },

  goToRandomGame: function () {
    Dorkle.games.fetch({
      success: function () {
        var randomGameId = Math.floor(Math.random() * Dorkle.games.length) + 1;
        var randomGamePath = 'games/' + randomGameId;
        Backbone.history.navigate(randomGamePath, {trigger: true});
      }
    });
  },

  doABarrelRoll: function () {
    this.barrelsRolled += 1;

    if (this.barrelsRolled >= 8) {
      Dorkle.flash.display("DO A BARREL ROLL!");
      this.barrelsRolled = 0;
    }
  }

});
