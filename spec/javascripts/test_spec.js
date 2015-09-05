// Model
describe("Board Model", function() {
  // this.stub = sinon.stub(jQuery, "ajax");

  describe("When instantiated", function(){
    // this.stub = sinon.stub(jQuery, "ajax");

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

  describe("when instantiated with model literal", function() {

      beforeEach(function() {
        this.boardStub = sinon.stub(TestDrivenTrello.Models, "Board");
        this.model = new Backbone.Model({
          id: 5,
          title: "Foo"
        });
        this.boardStub.returns(this.model);
        this.boards = new TestDrivenTrello.Collections.Boards();
        this.boards.model = TestDrivenTrello.Models.Board;
        this.boards.add({
          id: 5,
          title: "Foo"
        });
      });

      afterEach(function() {
        this.boardStub.restore();
      });

      it("should add a model", function() {
        // debugger;
        expect(this.boards.length).toEqual(1);
      });

      it("should find a model by id", function() {
        expect(this.boards.get(5).get("id")).toEqual(5);
      });

    });

    describe("when fetching models", function() {

      beforeEach(function() {
        this.fixture = this.fixtures.Boards.valid;
        this.boards = new TestDrivenTrello.Collections.Boards();
        this.server = sinon.fakeServer.create();
        this.server.respondWith(
          "GET",
          "/api/boards",
          this.validResponse(this.fixture)
        );
      });

      afterEach(function() {
        this.server.restore();
      });

      it("should make the correct request", function() {
        this.boards.fetch();

        expect(this.server.requests.length)
          .toEqual(1);
        expect(this.server.requests[0].method)
          .toEqual("GET");
        expect(this.server.requests[0].url)
          .toEqual("/api/boards");
      });

      it("should parse boards from the response", function() {
        this.boards.fetch();
        this.server.respond();
        expect(this.boards.length)
          .toEqual(this.fixture.response.boards.length);
        expect(this.boards.get(1).get('title'))
          .toEqual(this.fixture.response.boards[0].title);
      }); 

    });

});
