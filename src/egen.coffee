build ($) ->

  document = window.document

  $.egen = $.eGen = (queryTokens, attrs, innerNodes) ->
    tagName = id = null

    # generate element
    if not queryTokens
      queryTokens = []
      tagName = 'div'
    else
      if typeof queryTokens is 'string'
        queryTokens = queryTokens.split /(?![\w\-]+|$)/
      if queryTokens[0] and /^\w/.test queryTokens[0]
        tagName = queryTokens.shift()
      else
        tagName = 'div'
    element = document.createElement tagName

    # setup id, class
    while queryTokens.length
      tokenStr = queryTokens.shift()
      token = tokenStr.match(/([^\w\-])([\w\-]+)/)
      unless token and token.length == 3
        throw new $.egen.TokenError("The query token provided ('#{tokenStr}') is not a valid token.")
      switch token[1]
        when '#'
          element.id = token[2]
        when '.'
          element.classList.add token[2]
        else
          throw new $.egen.TokenError("The query token provided ('#{tokenStr}') is not a valid token type.")

    # set attributes
    if attrs
      for name, value of attrs
        if value or value == 0
          element.setAttribute name, value
        else
          element.removeAttribute name

    if innerNodes
      $(element).append(innerNodes)
    else
      $(element)

  $.fn.egen = $.fn.eGen = (queryTokens, attrs, innerNodes) ->
    if innerNodes
      @append $.egen(queryTokens, attrs).append(innerNodes)
    else
      @append $.egen(queryTokens, attrs)

  class $.egen.TokenError
    constructor: (message) ->
      @message = message
      @name = 'TokenError'
