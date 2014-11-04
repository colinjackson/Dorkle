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
    this.$answerBox = this.$('#answer-box');

    return this;
  },

  makeGameAnswer: function (event) {
    event.preventDefault();

    var newAnswerAttrs = this.$el.serializeJSON();
    if (this.collection.game.id) {
      newAnswerAttrs.game_id = this.collection.game.id
      this.collection.create(newAnswerAttrs, {wait: true});
    } else {
      this.collection.add(newAnswerAttrs);
    }
    this.$answerBox.val('');
  }

});
