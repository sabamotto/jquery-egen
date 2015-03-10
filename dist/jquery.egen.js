(function() {var build;

build = function(factory) {
  if (typeof define === 'function' && define.amd) {
    return define(['jquery'], factory);
  } else if (typeof exports === 'object') {
    return factory(require('jquery'));
  } else {
    return factory(jQuery);
  }
};

//

build(function($) {
  var document;
  document = window.document;
  $.egen = $.eGen = function(queryTokens, attrs, innerNodes) {
    var element, id, name, tagName, token, tokenStr, value;
    tagName = id = null;
    if (!queryTokens) {
      queryTokens = [];
      tagName = 'div';
    } else {
      if (typeof queryTokens === 'string') {
        queryTokens = queryTokens.split(/(?![\w\-]+|$)/);
      }
      if (queryTokens[0] && /^\w/.test(queryTokens[0])) {
        tagName = queryTokens.shift();
      } else {
        tagName = 'div';
      }
    }
    element = document.createElement(tagName);
    while (queryTokens.length) {
      tokenStr = queryTokens.shift();
      token = tokenStr.match(/([^\w\-])([\w\-]+)/);
      if (!(token && token.length === 3)) {
        throw new $.egen.TokenError("The query token provided ('" + tokenStr + "') is not a valid token.");
      }
      switch (token[1]) {
        case '#':
          element.id = token[2];
          break;
        case '.':
          element.classList.add(token[2]);
          break;
        default:
          throw new $.egen.TokenError("The query token provided ('" + tokenStr + "') is not a valid token type.");
      }
    }
    if (attrs) {
      for (name in attrs) {
        value = attrs[name];
        if (value || value === 0) {
          element.setAttribute(name, value);
        } else {
          element.removeAttribute(name);
        }
      }
    }
    if (innerNodes) {
      return $(element).append(innerNodes);
    } else {
      return $(element);
    }
  };
  $.fn.egen = $.fn.eGen = function(queryTokens, attrs, innerNodes) {
    if (innerNodes) {
      return this.append($.egen(queryTokens, attrs).append(innerNodes));
    } else {
      return this.append($.egen(queryTokens, attrs));
    }
  };
  return $.egen.TokenError = (function() {
    function TokenError(message) {
      this.message = message;
      this.name = 'TokenError';
    }

    return TokenError;

  })();
});

//
}).call(this);
//# sourceMappingURL=jquery.egen.js.map