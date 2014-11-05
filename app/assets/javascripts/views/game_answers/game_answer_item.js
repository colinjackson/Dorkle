Dorkle.Views.GameAnswerItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-answer-item group',
  template: JST['game_answers/_item'],

  events: {
    'click .game-answer-item-answer': 'beginEditing',
    'focusout input.game-answer-item-editing': 'endEditing',
    'keydown input.game-answer-item-editing': 'checkForEnter',
    'click button.game-answer-delete': 'deleteAnswer'
  },
  checkForEnter: function (event) {
    if (event.which === 13) this.$editBox.blur();
  },

  render: function () {
    var renderedContent = this.template({
      gameAnswer: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  beginEditing: function (event) {
    event.preventDefault();

    var $item = $(event.currentTarget);
    this.$editBox = $('<input type="text">');
    this.$editBox.addClass('game-answer-item-editing');

    $item.replaceWith(this.$editBox);
    this.$editBox.val(this.model.get('answer'));
    this.$editBox.select();
  },

  endEditing: function (event) {
    event.preventDefault();

    this.model.set('answer', this.$editBox.val());
    if (this.model.id) this.model.save({}, {
      error: function (model, response) {
        Dorkle.flash.displayError('Drats! ' + response.errors);
      }
    });

    this.$editBox = null;
    this.render();
  },



  deleteAnswer: function (event) {
    event.preventDefault();
    this.model.destroy();
  }
});
