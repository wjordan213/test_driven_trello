TestDrivenTrello.Collections.Boards = Backbone.Collection.extend({
  model: TestDrivenTrello.Models.Board,
  url: "/api/boards"
});
