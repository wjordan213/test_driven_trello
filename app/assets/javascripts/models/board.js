TestDrivenTrello.Models.Board = Backbone.Model.extend({
  validate: function(attrs) {
    if(!attrs.title) {
      return "cannot have an empty title";
    }
  }
});
