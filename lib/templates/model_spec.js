/* jshint node: true */
/* global describe, it, beforeEach */
'use strict';

define(function(require){
  var expect = require('chai').expect;
  var <%= @name.camelize() %> = require('models/<%= @name %>')
  var Maquila = require('maquila');

  describe('<%= @type %>s', function() {
    var <%= @name %>;
    
    beforeEach(function(){
      <%= @name %> = Maquila.build('<%= @name %>');
    });

    describe('<%= @name %>', function(){
      it("should build an instance of <%= @name.camelize() %>", function(){
        expect(<%= @name %>).to.be.instanceOf(<%= @name.camelize() %>)
      });
    });
  });
});
