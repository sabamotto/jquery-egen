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

test 'create nest tags', ->
  expect 2
  $elem = $.egen('#root span.lv1  .lv2  i.lv3', null, 'nested text', true)
  ok $($elem.children('.lv1')).hasClass('lv1'), 'should contain a nested element'
  strictEqual $elem.find('.lv1 > .lv2 > i.lv3').text(), 'nested text', 'should contain a text in deepest element'

test 'create an element with XSS text', ->
  expect 2
  $elem = $.egen('code#XSS', null, '<script>alert("XSS!");</script>')
  strictEqual $elem.find('script').size(), 0, 'should not contain script element'
  $elem = $elem.egen('code#XSS', null, '<script>alert("XSS!");</script>')
  strictEqual $elem.find('script').size(), 0, 'should not contain script element'

test 'throws for illegal query', ->
  throws ->
    $.egen('##illegalQuery##')
  , /is not a valid token./, 'raised error message contains "is not a valid token"'
  throws ->
    $.egen('#unsupported:token')
  , /is not a valid token type./, 'raised error message contains "is not a valid token type"'
