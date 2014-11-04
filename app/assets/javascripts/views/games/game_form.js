Dorkle.Views.GameForm = Backbone.View.extend({
  tagName: 'form',
  className: 'default',
  template: JST['games/_form'],

  initialize: function (options) {
    this.buttonText = options.buttonText;

    this.listenTo(this.model, 'sync', this.render)
  },

  events: {
    'change #game_image': 'pullInImage'
  },

  render: function () {
    var renderedContent = this.template({
      game: this.model,
      buttonText: this.buttonText
    });
    this.$el.html(renderedContent);

    return this;
  },

  pullInImage: function (event) {
    var imageFile = event.currentTarget.files[0];
    var reader = new FileReader();

    var view = this;
    reader.onloadend = function () {
      view.model.set('image', this.result);
      view._updateImagePreview(this.result);
    };

    if (imageFile) {
      reader.readAsDataURL(imageFile);
    } else {
      this._updateImagePreview("");
    }
  },

  _updateImagePreview: function (imageData) {
    this.$('#game-image-preview').attr('src', imageData);
  }
});
