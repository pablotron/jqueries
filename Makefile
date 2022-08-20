
.PHONY=all
all: public/index.html public/js/script.min.js public/style.min.css

public/index.html: bin/gen-index.rb
	ruby bin/gen-index.rb | minify --type html > public/index.html

public/js/script.min.js: public/js/script.js
	minify public/js/script.js > public/js/script.min.js

public/style.min.css: public/style.css
	minify public/style.css > public/style.min.css

test: all
	xdg-open public/index.html
