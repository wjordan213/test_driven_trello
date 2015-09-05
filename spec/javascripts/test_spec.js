// Model
describe("Board Model", function() {
  // this.stub = sinon.stub(jQuery, "ajax");

  describe("When instantiated", function(){
    this.stub = sinon.stub(jQuery, "ajax");

    beforeEach(function() {
      this.board = new TestDrivenTrello.Models.Board({ title: 'a title'});
      var collection = {
        url: "/api/boards"
      };
      this.board.collection = collection;
    });

    it("should expose an attribute", function() {
      expect(this.board.get('title')).toEqual('a title');
    });

    describe("url", function() {

      describe("when no id is set", function() {
        it("should return the collection url", function(){
          expect(this.board.url()).toEqual('/api/boards');
        });
      });

      describe ("when id is set", function() {
        it("should return the collection url and id", function() {
          this.board.set('id', 1);
          expect(this.board.url()).toEqual('/api/boards/1');
        });
      });

    });

    it("should not save when title is empty", function() {
      this.board.set('id', 1);
      var eventSpy = sinon.spy();
      this.board.on("invalid", eventSpy);
      this.board.save({title: ""});
      expect(eventSpy).toHaveBeenCalledOnce();
      expect(eventSpy).toHaveBeenCalledWith(
        this.board,
        "cannot have an empty title"
      );
    });

  });

});

// Collection

var spy = sinon.spy();

describe ("Boards Collection", function() {
});
