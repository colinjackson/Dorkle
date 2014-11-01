window.Dorkle = {
  Utils: {},
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Dorkle.games = new Dorkle.Collections.Games()

    new Dorkle.Routers.SiteRouter({
      $mainEl: $('main')
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Dorkle.initialize();
});
