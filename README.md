# jqueries

Every version of [jQuery][] on the same page.

## Build

Load `public/index.html` and marvel at the chaos.

If you want to regenerate the contents, do the following:

```
# download all versions of jquery to public/js
bin/fetch.rb

# regenerate index.html
bin/gen-index.rb | minify --type html > public/index.html
```

[jquery]: https://jquery.com/
  "jQuery"
