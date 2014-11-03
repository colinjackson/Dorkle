Dorkle.Views.UserShow = Backbone.Superview.extend({
  template: JST['users/show'],

  initialize: function () {
    this.listenTo(this.model.createdGames(), 'add', this.addGame);
  },

  render: function () {
    var renderedContent = this.template({
      user: this.model
    });
    this.$el.html(renderedContent);

    var detailsSubview = new Dorkle.Views.UserDetails({
      model: this.model
    });
    this.addSubview('div.user-details', detailsSubview);

    var view = this;
    this.model.createdGames().each(function (game) {
      view.addGame(game);
    });

    return this;
  },

  addGame: function (game) {
    var subview = new Dorkle.Views.GameItem({
      model: game
    });

    this.addSubview('ul.user-created-games', subview);
  }
})
