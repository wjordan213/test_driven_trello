TestDrivenTrello.Collections.Boards = Backbone.Model.extend({
  url: '/api/boards',
  model: TestDrivenTrello.Models.Note
});
