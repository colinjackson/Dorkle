Dorkle.Models.Round = Backbone.Model.extend({
  urlRoot: '/api/rounds',

  parse: function (json) {
    if (json.game) {
      this.game = Dorkle.games.add(json.game);
      delete json.game;
    }
    if (json.answers) {
      this.answers().set(json.answers);
      delete json.answers;
    }
    if (json.answer_matches) {
      this.matches().set(json.answer_matches);
      delete json.answer_matches;
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
      this._matches = new Dorkle.Collections.RoundAnswerMatches([], {
        round: this
      });
    }

    return this._matches;
  },

  validAnswers: function () {
    if (this.matches().length === 0) return this.answers().clone();

    var matchedAnswerIds = [];
    this.matches().each(function (match) {
      matchedAnswerIds.push(match.get('answer_id'));
    });

    var validAnswers = new Dorkle.Collections.GameAnswers([], {
      game: this.game
    });
    this.answers().each(function (answer) {
      if (matchedAnswerIds.indexOf(answer.id) === -1) {
        validAnswers.add(answer);
      }
    });

    return validAnswers;
  },

  isAnswerMatched: function (answer) {
    var matchedAnswerIds = [];
    this.matches().each(function (match) {
      matchedAnswerIds.push(match.get('answer_id'));
    })

    return matchedAnswerIds.indexOf(answer.id) !== -1
  },

  timeRemaining: function () {
    if (!this.game) return 0;
    if (!this.get('start_time')) return this.game.get('time_limit');

    var timeElapsed = (Date.now() - Date.parse(this.get('start_time'))) / 1000;
    var timeLimit = this.game.get('time_limit');
    return Math.max((timeLimit - timeElapsed), 0);
  },

  answersLeft: function () {
    return this.answers().length - this.matches().length;
  },

  isWon: function () {
    return this.answers().length === this.matches().length;
  }

});
