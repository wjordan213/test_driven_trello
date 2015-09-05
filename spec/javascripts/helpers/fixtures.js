beforeEach(function() {

  this.fixtures = {

    Boards: {
      valid: { // response starts here
        "status": "OK",
        "version": "1.0",
        "response": {
          "boards": [
            {
              "id": 1,
              "title": "Destroying Alderaan"
            },
            {
              "id": 2,
              "title": "Building the death star"
            }
          ]
        }
      }
    }

  };

});
