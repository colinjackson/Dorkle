Dorkle.Views.GameShow = Backbone.View.extend({
  template: JST['games/show'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    'click button.round-start': 'startRound'
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

    var roundShowPath = '/games/' + this.model.id + '/round';
    Backbone.history.navigate(roundShowPath, {trigger: true});
  }

});
