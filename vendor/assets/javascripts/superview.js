// I wrote this myself, but it bites so heavily from the basic App Academy
// version of it that I feel it belongs in vendor.

Backbone.Superview = Backbone.View.extend({
  addSubview: function (selector, subview) {
    this.subviews(selector).push(subview);
    this.attachSubview(selector, subview.render());
  },

  attachSubview: function (selector, subview) {
    this.$(selector).append(subview.$el)
    subview.delegateEvents();

    if (subview.attachSubviews) {
      subview.attachSubviews();
    }
  },

  attachSubviews: function () {
    var view = this;
    _(view.subviews()).each(function (subviews, selector) {
      view.$(selector).empty();
      _(subviews).each(function (subview) {
        view.attachSubview(selector, subview);
      });
    });
  },

  removeSubview: function (selector, subview) {
    subview.remove();
    var index = this.subviews(selector).indexOf(subview);
    this.subviews(selector).splice(index, 1);
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    _(this.subviews()).each(function (subviews, selector) {
      _(subviews).each(function (subview) {
        subview.remove();
      });
    });
  },

  subviews: function (selector) {
    this._subviews = this._subviews || {};

    if (selector) {
      this._subviews[selector] = this._subviews[selector] || [];
      return this._subviews[selector];
    } else {
      return this._subviews;
    }
  }
});
