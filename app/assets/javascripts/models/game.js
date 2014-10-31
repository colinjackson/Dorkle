Dorkle.Models.Game = Backbone.Model.extend({
  urlRoot: 'api/games',

  getSubtitle: function () {
    if (this.get("subtitle")) return this.get("subtitle");
    return "(no subtitle)";
  }
});
