/* jshint node: true */
'use strict';

define(['maquila', 'models/<%= @name %>'], function(Maquila, <%= @name.camelize() %>){
  Maquila.define('<%= @name %>', <%= @name.camelize() %>).defaults({
    <%= ("'#{a}': '#{a}'" for a in @attrs?.match(/\w+/g)).join(",\n    ") %>
  });
});
