// Model
describe("Board Model", function() {
  it("should expose an attribute", function() {
    var board = new TestDrivenTrello.Models.Board({ title: 'a title'});
    expect(board.get('title')).toEqual('a title');
  });
});

// Collection

describe ("Boards Collection", function() {
  it("")
});
