Dorkle.Views.RoundShow = Backbone.Superview.extend({
  template: JST['rounds/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      round: this.model
    });
    this.$el.html(renderedContent);

    return this;
  }

});
