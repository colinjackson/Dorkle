Dorkle.Views.NotificationItem = Backbone.View.extend({
  tagName: 'li',
  className: 'group',
  template: JST['notifications/_item'],

  events: {
    'click .notification-follow': 'followNotification',
    'click .notification-delete': 'deleteNotification'
  },

  render: function () {
    var renderedContent = this.template({
      notification: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  followNotification: function (event) {
    event.preventDefault();
    this.model.set('is_read', true);
    this.model.save();
    Backbone.history.navigate(this.model.get('path'), {trigger: true});
  },

  deleteNotification: function (event) {
    event.preventDefault();
    this.model.destroy();
  }

});
