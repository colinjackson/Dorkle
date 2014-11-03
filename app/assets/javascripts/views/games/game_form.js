Dorkle.Views.GameForm = Backbone.View.extend({
  tagName: 'form',
  className: 'default',
  template: JST['games/_form'],

  initialize: function (options) {
    this.buttonText = options.buttonText;
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model,
      buttonText: this.buttonText
    });
    this.$el.html(renderedContent);

    return this;
  }
});
