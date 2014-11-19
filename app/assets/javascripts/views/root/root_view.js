Dorkle.Views.RootView = Backbone.Superview.extend({
  className: 'root',
  template: JST['root/root'],

  initialize: function () {
    this.hotGames = new Dorkle.Collections.Games();
    this.bestPlayers = new Dorkle.Collections.Users();
    this.bestAuthors = new Dorkle.Collections.Users();

    this.listenTo(this.hotGames, 'add', this.addGame);
    this.listenTo(this.bestPlayers, 'add', this.addPlayer);
    this.listenTo(this.bestAuthors, 'add', this.addAuthor);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    this.prepareWave();

    var view = this
    this.hotGames.each(function (game) {
      view.addGame(game);
    });
    this.bestPlayers.each(function (player) {
      view.addPlayer(player);
    });
    this.bestAuthors.each(function (author) {
      view.addAuthor(author);
    });

    this.getData();

    return this;
  },

  addGame: function (game) {
    var subview = new Dorkle.Views.GameItem({
      model: game
    });
    this.addSubview('ul.hot-games-list', subview);
  },

  addPlayer: function (player) {
    var subview = new Dorkle.Views.UserItem({
      model: player,
      itemType: 'best players'
    });
    this.addSubview('ul.leaderboard-best-players-list', subview)
  },

  addAuthor: function (author) {
    var subview = new Dorkle.Views.UserItem({
      model: author,
      itemType: 'best authors'
    });
    this.addSubview('ul.leaderboard-best-authors-list', subview)
  },

  getData: function () {
    $.ajax({
      type: "get",
      url: '/api',
      dataType: "json",
      success: function (data) {
        this.saveResults(data);
      }.bind(this)
    });
  },

  saveResults: function (data) {
    this.hotGames.set(data.hot_games);
    this.bestPlayers.set(data.best_players);
    this.bestAuthors.set(data.best_authors);
  },

  prepareWave: function () {
    if (document.cookie.indexOf('dorkle_danced=true') !== -1) return false;
    document.cookie = 'dorkle_danced=true'

    var dorkly = this.$('.dorkle-logo');
    $(setTimeout(function () {
      dorkly.addClass('wavehello');
      setTimeout(function () {
        dorkly.removeClass('wavehello');
      }, 5000);
    }, 2000));
  }
})
