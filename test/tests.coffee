test 'create a DIV element', ->
  expect 3
  $elem = $.egen()
  strictEqual $elem.size(), 1, 'should generate an DIV element'
  strictEqual $elem.prop('tagName'), 'DIV', 'should be DIV element'
  strictEqual $elem.contents().size(), 0, 'should be an empty element'

test 'create a SPAN element with id and classes', ->
  expect 3
  $elem = $.egen('span.foo#bar')
  strictEqual $elem.prop('tagName'), 'SPAN', 'should be SPAN element'
  ok $elem.hasClass('foo'), 'should have a class'
  strictEqual $elem.attr('id'), 'bar', 'should be an id'

test 'create an A element with link and text', ->
  expect 1
  $elem = $.egen('A', {
    'src': '#ok',
    'lang': 'en',
  }).text('Test linking')
  strictEqual $elem.attr('src'), '#ok', 'should set an attribute'

test 'create chaining tags', ->
  expect 2
  $elem = $.egen('h1').egen('.text', null, 'heading')
  strictEqual $elem.contents().size(), 1, 'should contain a H2 element'
  strictEqual $elem.text(), 'heading', 'should contain a text'

test 'throws for illegal query', ->
  throws ->
    $.egen('##illegalId')
  , /is not a valid token./, 'raised error message contains "is not a valid token"'
  throws ->
    $.egen('#unsupported:token')
  , /is not a valid token type./, 'raised error message contains "is not a valid token type"'
  throws ->
    $.egen('#chain .tokens')
  , /is not a valid token./, 'raised error message contains "is not a valid token"'
