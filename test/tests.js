test('create a DIV element', function() {
  var $elem;
  expect(3);
  $elem = $.egen();
  strictEqual($elem.size(), 1, 'should generate an DIV element');
  strictEqual($elem.prop('tagName'), 'DIV', 'should be DIV element');
  return strictEqual($elem.contents().size(), 0, 'should be an empty element');
});

test('create a SPAN element with id and classes', function() {
  var $elem;
  expect(3);
  $elem = $.egen('span.foo#bar');
  strictEqual($elem.prop('tagName'), 'SPAN', 'should be SPAN element');
  ok($elem.hasClass('foo'), 'should have a class');
  return strictEqual($elem.attr('id'), 'bar', 'should be an id');
});

test('create an A element with link and text', function() {
  var $elem;
  expect(1);
  $elem = $.egen('A', {
    'src': '#ok',
    'lang': 'en'
  }).text('Test linking');
  return strictEqual($elem.attr('src'), '#ok', 'should set an attribute');
});

test('create chaining tags', function() {
  var $elem;
  expect(2);
  $elem = $.egen('h1').egen('.text', null, 'heading');
  strictEqual($elem.contents().size(), 1, 'should contain a H2 element');
  return strictEqual($elem.text(), 'heading', 'should contain a text');
});

test('throws for illegal query', function() {
  throws(function() {
    return $.egen('##illegalId');
  }, /is not a valid token./, 'raised error message contains "is not a valid token"');
  throws(function() {
    return $.egen('#unsupported:token');
  }, /is not a valid token type./, 'raised error message contains "is not a valid token type"');
  return throws(function() {
    return $.egen('#chain .tokens');
  }, /is not a valid token./, 'raised error message contains "is not a valid token"');
});

//# sourceMappingURL=tests.js.map
