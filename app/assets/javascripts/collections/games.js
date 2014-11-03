Dorkle.Collections.Games = Backbone.Collection.extend({
  model: Dorkle.Models.Game,
  url: '/api/games',

  getOrFetch: function (id) {
    game = this.get(id);

    if (!game) {
      game = new Dorkle.Models.Game({id: id});
      game.fetch({
        success: function () {
          this.add(game);
        }.bind(this)
      });
    } else {
      game.fetch();
    }

    return game;
  }
});
