Dorkle.Views.UserItem = Backbone.View.extend({
  tagName: 'li',
  className: 'user-item',
  template: JST['users/_item'],

  events: {
    'click a': 'goToUser'
  },

  render: function () {
    var renderedContent = this.template({
      user: this.model,
      itemType: this.itemType
    });
    this.$el.html(renderedContent);

    return this;
  },

  goToUser: function (event) {
    event.preventDefault();
    var userPath = '/users/' + this.model.id;
    Backbone.history.navigate(userPath, {trigger: true});
  }
})
