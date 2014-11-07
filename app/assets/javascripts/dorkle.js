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
      Dorkle.notifications = new Dorkle.Views.NotificationDisplay({
        el: $('#notification-display')
      });
    }

    Backbone.history.start({pushState: true});
  }
};

$(document).ready(function(){
  Dorkle.initialize();
});
