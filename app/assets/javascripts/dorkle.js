window.Dorkle = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Dorkle.Routers.SiteRouter({
      $mainEl: $("main")
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Dorkle.initialize();
});
