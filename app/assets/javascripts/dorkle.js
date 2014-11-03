window.Dorkle = {
  Utils: {},
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Dorkle.games = new Dorkle.Collections.Games()
    Dorkle.currentUserId = $('#current-user').data('id');

    Dorkle.siteRouter = new Dorkle.Routers.SiteRouter({
      $mainEl: $('main')
    });
    Dorkle.header = new Dorkle.Views.Header({el: $('header')});

    Backbone.history.start({pushState: true});
  }
};

$(document).ready(function(){
  // Dorkle.initialize();
});
