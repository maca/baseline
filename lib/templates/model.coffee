define ['spine/ajax'], (Spine) ->

  class <%= @name.camelize() %> extends Spine.Model
    @configure '<%= @name.camelize() %>'<%= @attrs and ', '+("'#{a}'" for a in @attrs.match(/\w+/g)).join(', ') %>
