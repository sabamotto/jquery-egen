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
      else
        queryTokens = queryTokens.concat() # duplicate
      if queryTokens[0] and /^\w/.test queryTokens[0]
        tagName = queryTokens.shift()
      else
        tagName = 'div'
    element = document.createElement tagName
    $element = $(element)

    # setup id, class
    while queryTokens.length
      tokenStr = queryTokens.shift()
      if tokenStr == ' '
        if queryTokens[0].indexOf(' ') < 0
          # nested element without tag-name
          innerContents = $.egen(queryTokens, null, innerContents)
          queryTokens = []
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
          innerContents = $.egen(queryTokens, null, innerContents)
          queryTokens = []
          continue
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
    @append $.egen(queryTokens, attrs, innerContents)
