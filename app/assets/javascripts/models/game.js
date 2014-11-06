Dorkle.Models.Game = Backbone.Model.extend({
  urlRoot: '/api/games',

  toJSON: function () {
    return { game: _.clone(this.attributes) }
  },

  parse: function (json) {
    if (json.author) {
      this.author = new Dorkle.Models.User(json.author);
      delete json.author
    }

    return json;
  },

  getSubtitle: function () {
    if (this.escape('subtitle')) return this.escape('subtitle');
    return '(no subtitle)';
  }
});
