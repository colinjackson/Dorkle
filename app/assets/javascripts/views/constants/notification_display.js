Dorkle.Views.NotificationDisplay = Backbone.Superview.extend({

  initialize: function () {
    this.$('.notification-dropdown').empty();
    this.$badge = this.$('.notifications-badge');

    this.listenTo(this.collection, 'add', this.addNotification);
    this.listenTo(this.collection, 'remove', this.removeNotification);

    setInterval(function () { this.collection.fetch() }.bind(this), 30000);
  },

  addNotification: function (notification) {
    this.$badge.text(this.collection.count);

    var subview = new Dorkle.Views.NotificationItem({
      model: notification
    });

    this.addSubview('ul.notification-dropdown', subview);
    this.$badge.text(this.collection.length);
  },

  removeNotification: function (notification) {
    this.$badge.text(this.collection.length);

    var removingSubview;
    _(this.subviews('ul.notification-dropdown')).each(function (subview) {
      if (subview.model === notification) removingSubview = subview;
    });

    this.removeSubview('ul.notification-dropdown', removingSubview);
  }

});
