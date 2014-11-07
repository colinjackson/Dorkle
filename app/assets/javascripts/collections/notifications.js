Dorkle.Collections.Notifications = Backbone.Collection.extend({
  model: Dorkle.Models.Notification,
  url: function () {
    return this.user.url() + '/notifications'
  },

  initialize: function (models, options) {
    if (options.user) this.user = options.user;
  }
});
