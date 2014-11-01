Dorkle.Models.Game = Backbone.Model.extend({
  urlRoot: 'api/games',

  parse: function (json) {
    if (json.author) {
      this.author = new Dorkle.Models.User(json.author);
      delete json.author
    }

    return json;
  },

  getSubtitle: function () {
    if (this.get('subtitle')) return this.get('subtitle');
    return '(no subtitle)';
  }
});
