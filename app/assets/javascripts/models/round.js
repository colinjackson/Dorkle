Dorkle.Models.Round = Backbone.Model.extend({
  urlRoot: 'api/rounds',

  parse: function (json) {
    if (json.game) {
      this.game = Dorkle.games.add(json.game);
      delete json.game;
    }

    if (json.answers) {
      this.answers().set(json.answers);
      delete json.answers;
    }

    return json;
  },

  answers: function () {
    if (!this._answers) {
      this._answers = new Dorkle.Collections.GameAnswers([], {
        game: this.game
      });
    }

    return this._answers;
  },

  matches: function () {
    if (!this._matches) {
      this._matches = new Dorkle.Collections.RoundAnswerMatches();
    }

    return this._matches;
  },

  timeRemaining: function () {
    if (this.game) {
      var timeElapsed = (Date.now() - Date.parse(this.get('created_at'))) / 1000;
      var timeLimit = this.game.get('time_limit');
      return timeLimit - timeElapsed;
    } else {
      return 0;
    }
  },

  answersLeft: function () {
    return this.answers().length - this.matches().length;
  },

  isWon: function () {
    return this.answers().length === this.matches().length;
  }

});
