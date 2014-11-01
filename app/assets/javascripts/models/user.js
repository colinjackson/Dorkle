Dorkle.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',

  getName: function () {
    return (this.get('name') ? this.get('name') : this.get('username'));
  }
});
