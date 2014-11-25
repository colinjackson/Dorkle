window.Dorkle = {
  Utils: {},
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Dorkle.games = new Dorkle.Collections.Games()

    Dorkle.siteRouter = new Dorkle.Routers.SiteRouter({
      $mainEl: $('main')
    });
    Dorkle.header = new Dorkle.Views.Header({el: $('body > header')});
    Dorkle.flash = new Dorkle.Views.Flash({el: $('div#flash')});

    Dorkle.currentUserId = $('#current-user').data('id');
    if (Dorkle.currentUserId) {
      Dorkle.currentUser = new Dorkle.Models.User({id: Dorkle.currentUserId});
      var notifications = new Dorkle.Collections.Notifications([], {
        user: Dorkle.currentUser
      });

      Dorkle.notifications = new Dorkle.Views.NotificationDisplay({
        el: $('#notification-display'),
        collection:notifications
      });
      notifications.fetch();
    }

    Backbone.history.start({pushState: true});
  }
};

$(document).ready(function(){
  // Dorkle.initialize();
});
