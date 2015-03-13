build ($) ->

  document = window.document

  $.egen = $.eGen = (queryTokens, attrs, innerContents, raw) ->
    tagName = id = null

    # generate element
    if not queryTokens
      queryTokens = []
      tagName = 'div'
    else
      if typeof queryTokens is 'string'
        queryTokens = queryTokens.split /(?![\w\-]+|$)/
      else if not raw
        queryTokens = queryTokens.concat() # duplicate
      if queryTokens[0] and /^\w/.test queryTokens[0]
        tagName = queryTokens.shift()
      else
        tagName = 'div'
    element = document.createElement tagName
    $element = $(element) unless raw

    # set attributes
    $element.attr attrs if not raw and attrs

    # setup id, class
    while queryTokens.length
      tokenStr = queryTokens.shift()
      if tokenStr == ' '
        if queryTokens[0].indexOf(' ') < 0
          # nested element without tag-name
          element.appendChild $.egen(queryTokens, null, innerContents, 1)
          innerContents = 0
          break
        continue
      token = tokenStr.match(/([^\w\-])([\w\-]+)/)
      unless token and token.length == 3
        throw "The query token provided ('#{tokenStr}') is not a valid token."
      switch token[1]
        when '#'
          element.id = token[2]
        when '.'
          element.classList.add token[2]
        when ' '
          # nested element with tag-name
          queryTokens.unshift token[2]
          element.appendChild $.egen(queryTokens, null, innerContents, 1)
          innerContents = 0
        else
          throw "The query token provided ('#{tokenStr}') is not a valid token type."

    # set inner contents
    if innerContents
      if typeof innerContents is 'string'
        # disable html code
        element.appendChild document.createTextNode(innerContents)
      else
        $element = $(element) if raw
        $element.append(innerContents)

    if raw
      element
    else
      $element

  $.fn.egen = $.fn.eGen = (queryTokens, attrs, innerContents) ->
    @append $.egen(queryTokens, attrs, innerContents)
