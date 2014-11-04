Dorkle.Views.GameShow = Backbone.View.extend({
  className: 'game-show',
  template: JST['games/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    'click button.round-start': 'startRound',
    'click a.game-show-manage-update': 'updateGame'
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  startRound: function (event) {
    event.preventDefault();
    Dorkle.siteRouter.roundCreate(this.model);
  },

  updateGame: function (event) {
    event.preventDefault();

    editGamePath = '/games/' + this.model.id + '/edit';
    Backbone.history.navigate(editGamePath, {trigger: true});
  }

});
