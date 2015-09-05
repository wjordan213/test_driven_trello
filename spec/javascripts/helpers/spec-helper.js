beforeEach(function() {

    this.validResponse = function(responseText) {
      return [
        200,
        {"Content-type": "application/json"},
        JSON.stringify(responseText)
      ];
    };

});
