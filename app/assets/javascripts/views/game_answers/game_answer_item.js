Dorkle.Views.GameAnswerItem = Backbone.View.extend({
  tagName: 'li',
  className: 'game-answer-item group',
  template: JST['game_answers/_item'],

  events: {
    'click button.game-answer-remove': 'deleteAnswer'
  },

  render: function () {
    var renderedContent = this.template({
      gameAnswer: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  deleteAnswer: function (event) {
    event.preventDefault();

    this.model.destroy();
  }
});
