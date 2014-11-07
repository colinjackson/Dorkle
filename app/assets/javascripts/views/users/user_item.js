Dorkle.Views.UserItem = Backbone.View.extend({
  tagName: 'li',
  className: 'user-item',
  template: JST['users/_item'],

  render: function () {
    var renderedContent = this.template({
      user: this.model,
      itemType: this.itemType
    });
    this.$el.html(renderedContent);

    return this;
  }
})
