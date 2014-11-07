Dorkle.Views.UserShow = Backbone.Superview.extend({
  className: 'user-show group',
  template: JST['users/show'],

  initialize: function () {
    this.listenTo(this.model, "change:image_url_show", this.updateImage);
    this.listenTo(this.model, 'change:username change:name', this.updateTitle);
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
    this.addSubview('div.user-show-content', detailsSubview);

    var view = this;
    this.model.createdGames().each(function (game) {
      view.addGame(game);
    });

    return this;
  },

  updateTitle: function () {
    this.$('h1').text(this.model.getName());
  },

  updateImage: function () {
    $('.user-show-content > img')
      .attr('src', this.model.escape('image_url_show'));
  },

  addGame: function (game) {
    var subview = new Dorkle.Views.GameItem({
      model: game
    });

    this.addSubview('ul.user-show-created-games-list', subview);
  }
})
