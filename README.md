# jQuery-eGen

A simple jQuery plugin for generating element by a query string.

jQuery-eGen is inspired by [Slim](https://github.com/slim-template/slim).

- Website: http://sabamotto.github.io/jquery-egen/
- For downloads: https://github.com/sabamotto/jquery-egen/releases/
- Examples: http://sabamotto.github.io/jquery-egen/examples.html

## Installation

Include eGen script after the jQuery library.
```html
<script src="your/js/path/jquery.min.js"></script>
<script src="your/js/path/jquery.egen.min.js"></script>
```

Or, include it in your script package.

## Usage

Create simple div element:
```javascript
div = $.egen()
```

Create element with id or classes:
```javascript
icon = $.egen('i.fa.fa-spinner.fa-spin#waitIcon');
```

Create paragraph element with alignment, and append to body:
```javascript
$('body').egen('p', { align: 'center' }, 'welcome to eGen!');
```

Create nested element:
```javascript
warnText = $.egen('p.warn b i', { align: 'center' }, 'Bold and Italic');
```

see also [examples](https://github.com/sabamotto/jquery-egen/tree/master/examples).

## Build

To build eGen by yourself, first of make sure you have Node.js, Grunt and JRE installed.

1. Clone eGen repository
```
git clone https://github.com/sabamotto/jquery-egen.git
cd jquery-egen
```

2. Install Node.js dependencies
```
npm install
```

3. Run `grunt` to generate a script in folder `dist`.
```
grunt
```

## License

Copyright (c) 2015 SabaMotto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## Author

[@sabamotto](https://twitter.com/sabamotto)
