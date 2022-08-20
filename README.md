# jqueries

Almost every version of [jQuery][] on the same page.

See `public/js/script.js` for the unminified code which loads all
versions simultaneously.

## Build

Load `public/index.html` and marvel at the chaos.

If you want to regenerate the contents, run `make`.  Requires
[`minify`][minify] and [Ruby][].

```
# download all versions of jquery to public/js
bin/fetch.rb

# regenerate index.html
bin/gen-index.rb | minify --type html > public/index.html
```

[jquery]: https://jquery.com/
  "jQuery"
[minify]: https://github.com/tdewolff/minify
  "Command-line minifier."
[ruby]: https://ruby-lang.org/
  "Ruby programming language."
