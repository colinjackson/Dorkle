Dorkle.Views.NotificationDisplay = Backbone.Superview.extend({

  initialize: function () {
    this.$('.notification-dropdown').empty();
    this.$badge = this.$('.notifications-badge');
    this.$dropdown = this.$('.notification-dropdown');
    this.updateEls();

    this.listenTo(this.collection, 'add', this.addNotification);
    this.listenTo(this.collection, 'remove', this.removeNotification);

    var channel = window.pusher.subscribe(Dorkle.Utils.userServer());
    channel.bind("new_notification", function (data) {
      this.collection.add(data);
    }.bind(this));

    setInterval(function () { this.collection.fetch() }.bind(this), 30000);
  },

  addNotification: function (notification) {
    var subview = new Dorkle.Views.NotificationItem({
      model: notification
    });

    this.addSubview('ul.notification-dropdown', subview);
    this.updateEls();
  },

  removeNotification: function (notification) {
    var removingSubview;
    _(this.subviews('ul.notification-dropdown')).each(function (subview) {
      if (subview.model === notification) removingSubview = subview;
    });

    this.removeSubview('ul.notification-dropdown', removingSubview);
    this.updateEls();
  },

  updateEls: function () {
    this.$badge.text(this.collection.length);
    if (this.collection.length) {
      this.$badge.removeClass('is-empty');
      this.$dropdown.removeClass('is-empty');
    } else {
      this.$badge.addClass('is-empty');
      this.$dropdown.addClass('is-empty');
    }
  }

});
