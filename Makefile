#
# Minimal Makefile for pablotron/jqueries.
#
# Targets:
#
# * all: Regenerate public/index.html (default target).
# * fetch: Fetch latest jQuery release page HTML, parse it, download all
#   versions of jQuery, then write them to `public/js`.
# * test: Open `public/index.html` in the local browser.
#

.PHONY=all fetch

# rebuild page contents (default target)
all: public/index.html public/js/script.min.js public/style.min.css

# 1. fetch HTML from jquery releases page and write it to `bin/releases.html`
# 2. parse HTML, fetch (almost) all versions of jquery, and write them to `public/js/`.
#
# Note: The result of this command is included in the repo, so you
# shouldn't need to execute it manually.
fetch:
	bundle exec bin/fetch-html.rb && bundle exec bin/fetch-jqueries.rb

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
