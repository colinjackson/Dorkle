Dorkle.Views.Flash = Backbone.View.extend({

  initialize: function () {
    this.$list = this.$('ul');

    this.handleServerFlashes();
  },

  handleServerFlashes: function () {
    var $flashes = this.$list.children();
    this.$list.empty();

    _($flashes).each(function (flash) {
      this._presentFlash(flash);
    }.bind(this));
  },

  display: function (message, cssClass) {
    var $flash = $('<li>');
    $flash.text(message).addClass(cssClass);

    this._presentFlash($flash);
  },

  displaySuccess: function (message) {
    this.display(message, 'flash-successes-message');
  },

  displayError: function (message) {
    this.display(message, 'flash-errors-message');
  },

  _presentFlash: function (flash) {
    var $flash = $(flash);
    this.$list.append($flash);

    setTimeout(function () {
      $flash.remove();
    }, 6000);
  }

});
