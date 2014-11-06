Dorkle.Views.GameAnswerItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-answer-item group',
  template: JST['game_answers/_item'],

  events: {
    'click .game-answer-show-dropdown': 'toggleDropdown',
    'keydown .game-answer-dropdown input': 'checkForEnter',
    'focusout .game-answer-dropdown input': 'checkForLostFocus',
    'click button.game-answer-save': 'saveAnswer',
    'click button.game-answer-delete': 'deleteAnswer'
  },

  toggleDropdown: function (event) {
    event.preventDefault();
    this.$button.toggleClass('active');
    this.$dropdown.toggleClass('active');

    if (this.$dropdown.hasClass('active')) {
      this.$('#game_answer_answer').select();
    }
  },

  checkForEnter: function (event) {
    if (event.which === 13) {
      this.saveAnswer(event);
      this.toggleDropdown(event);
    }
  },

  checkForLostFocus: function (event) {
    if (!$(event.relatedTarget).parent() === this.$dropdown) {
      this.toggleDropdown();
    }
  },

  render: function () {
    var renderedContent = this.template({
      gameAnswer: this.model
    });
    this.$el.html(renderedContent);
    this.$button = this.$('.game-answer-show-dropdown');
    this.$dropdown = this.$('.game-answer-dropdown');

    return this;
  },

  resetAnswerName: function () {
    this.$('.game-answer-item-answer').text(this.model.get('answer'));
  },

  saveAnswer: function (event) {
    event.preventDefault();

    var updateAttrs = this.$dropdown.serializeJSON();
    this.model.set(updateAttrs);
    this.model.save({}, {
      success: function () {
        Dorkle.flash.displaySuccess('Answer changes saved!');
        this.resetAnswerName();
      }.bind(this),
      error: function (model, response) {
        Dorkle.flash.displayError('Uh-oh! That didn\'t work out... Try again?')
      }
    });
  },

  deleteAnswer: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.toggleDropdown(event);
  }
});
