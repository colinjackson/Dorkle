Dorkle.Collections.Notifications = Backbone.Collection.extend({
  model: Dorkle.Models.Notification,
  url: function () {
    return this.user.url() + '/notifications'
  },

  initialize: function (models, options) {
    options.user && this.user = options.user;
  }
});
