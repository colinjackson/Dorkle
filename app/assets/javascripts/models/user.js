Dorkle.Models.User = Backbone.Model.extend({
  urlRoot: '/api/users',

  parse: function (json) {
    if (json.created_games) {
      this.createdGames().set(json.created_games);
      delete json.created_games;
    }

    return json;
  },

  createdGames: function () {
    if (!this._games) {
      this._games = new Dorkle.Collections.Games();
    }

    return this._games;
  },

  getName: function () {
    if (this.escape('name')) {
      return this.escape('name');
    } else {
      return this.escape('username');
    }
  }
});
