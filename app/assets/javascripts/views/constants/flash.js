Dorkle.Views.Flash = Backbone.View.extend({

  initialize: function () {
    this.$list = this.$('ul');
    this.currentFlashes = [];

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

    for (var i = 0; i < this.currentFlashes.length; i++) {
      if ($flash.text() === this.currentFlashes[i].text()) return false;
    }

    this.$list.append($flash);
    this.currentFlashes.push($flash);

    setTimeout(function () {
      $flash.remove();
      this.currentFlashes.shift();
    }.bind(this), 6000);
  }

});
