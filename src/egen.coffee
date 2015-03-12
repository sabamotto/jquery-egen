build ($) ->

  document = window.document

  $.egen = $.eGen = (queryTokens, attrs, innerContents) ->
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
    $element = $(element)

    # setup id, class
    while queryTokens.length
      tokenStr = queryTokens.shift()
      token = tokenStr.match(/([^\w\-])([\w\-]+)/)
      unless token and token.length == 3
        throw "The query token provided ('#{tokenStr}') is not a valid token."
      switch token[1]
        when '#'
          element.id = token[2]
        when '.'
          element.classList.add token[2]
        else
          throw "The query token provided ('#{tokenStr}') is not a valid token type."

    # set attributes
    $element.attr attrs if attrs

    # set inner contents
    if innerContents
      if typeof innerContents is 'string'
        # disable html code
        $element.text(innerContents)
      else
        $element.append(innerContents)

    $element

  $.fn.egen = $.fn.eGen = (queryTokens, attrs, innerContents) ->
    if innerContents
      @append $.egen(queryTokens, attrs, innerContents)
    else
      @append $.egen(queryTokens, attrs)
