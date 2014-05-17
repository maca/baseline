require.config
  baseUrl: '/'
  paths:
    jquery: 'vendor/jquery/dist/jquery'
    text: 'vendor/requirejs-text/text'

define ['jquery'], ($) ->
  console.log $
