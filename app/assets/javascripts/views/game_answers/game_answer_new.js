Dorkle.Views.GameAnswerNew = Backbone.View.extend({
  tagName: 'form',
  className: 'default',
  template: JST['game_answers/new'],

  events: {
    'click button.game-answers-form-submit': 'makeGameAnswer'
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);

    return this;
  },

  makeGameAnswer: function (event) {
    event.preventDefault();

    var newAnswerAttrs = this.$el.serializeJSON();
    if (this.collection.game.id) {
      newAnswerAttrs.game_id = this.collection.game.id
      this.collection.create(newAnswerAttrs, {
        error: function (model, response) {
          Dorkle.flash.displayError('Darn! ' + response.errors);
        }
      });
    } else {
      this.collection.add(newAnswerAttrs);
    }
    this.$('input').val('');
    this.$('#answer-box').focus();
  }

});
