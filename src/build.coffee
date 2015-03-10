build = (factory) ->
  if typeof define is 'function' and define.amd
    define ['jquery'], factory
  else if typeof exports is 'object'
    factory require('jquery')
  else
    factory jQuery
