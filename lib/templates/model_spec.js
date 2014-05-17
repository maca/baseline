/* jshint node: true */
/* global describe, it, beforeEach */
'use strict';

var <%= @name.camelize() %> = require('<%= "models/#{@name}" %>');
var expect = chai.expect;

describe('<%= @type %>s', function() {
  describe('<%= @name %>', function(){
    it("should be true", function() {
      expect(<%= @name.camelize() %>).to.be.an('object');
    });
  });
});
