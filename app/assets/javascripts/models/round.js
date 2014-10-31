Dorkle.Models.Round = Backbone.Model.extend({
  urlRoot: 'api/rounds',

  parse: function (json) {
    if (json.answers) {
      this.answers().set(json.answers);
      delete json.answers;
    }

    if (json.game) {
      this.game = Dorkle.games.add(json.game);
      delete json.game;
    }
    
    return json;
  },

  answers: function () {
    if (!this._answers) {
      this._answers = new Dorkle.Collections.GameAnswers({
        game: this
      });
    }

    return this._answers;
  }
})
