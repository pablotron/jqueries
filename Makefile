
.PHONY=all

# rebuild page contents (default target)
all: public/index.html public/js/script.min.js public/style.min.css

# scan jquery scripts in public/js and regenerate public/index.html
public/index.html: bin/gen-index.rb
	ruby bin/gen-index.rb | minify --type html > public/index.html

# minify public/js/script.js and write to public/js/script.min.js
public/js/script.min.js: public/js/script.js
	minify public/js/script.js > public/js/script.min.js

# minify public/style.css and write to public/style.min.css
public/style.min.css: public/style.css
	minify public/style.css > public/style.min.css

# load page locally
test: all
	xdg-open public/index.html
