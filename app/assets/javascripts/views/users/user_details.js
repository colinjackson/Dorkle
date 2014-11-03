Dorkle.Views.UserDetails = Backbone.View.extend({
  template: JST['users/_details'],

  initialize: function () {
    this.listenTo(this.model, 'change', this.render);
  },

  render: function () {
    var renderedContent = this.template({
      user: this.model,
      isCurrentUser: (this.model.id === Dorkle.currentUserId)
    });
    this.$el.html(renderedContent);

    return this;
  }
});
