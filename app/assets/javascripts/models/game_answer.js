Dorkle.Models.GameAnswer = Backbone.Model.extend({
  urlRoot: '/api/game_answers',

  initialize: function (options) {
    if (this.get('regex')) {
      var regexString = '^\\s*(' + this.get('regex') + ')\\s*$';
      this.regex = new RegExp(regexString);
    }
  },

  doesMatch: function (guess) {
    if (!this.regex) return false;
    return this.regex.test(guess);
  }
});
