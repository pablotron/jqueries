# jqueries

Tools to generate a page that uses (almost) every version of [jQuery][]
at the same time.  Each version of [jQuery][] on the generated page
handles the color cycling for it's row of the table.

You can see the result here:

[https://pablotron.github.io/jqueries/][site]

Relevant Files:

* `bin/gen-index.rb`: [Ruby][] script which generates `public/index.html`.
* `public/js/script.js`: unminified JavaScript which loads all
  versions of [jQuery][] simultaneously.
* `public/style.css`: Basic page style and animation color palette.
* `public/index.html`: Generated page.

## Why?

Some people dislike seeing [jQuery][] because it isn't really needed for
modern browsers (see [You Might Not Need jQuery][]).

Many older sites embed multiple versions of [jQuery][], often as
[transitive dependencies][].

I thought "wouldn't it be funny if there was a page that loaded *all*
versions of jQuery?".

## Build

Follow the instructions in this section if you want to regenerate
`public/index.html`.

Requirements:

* [Ruby][]: Ruby programming language.
* [Bundler][]: [Ruby][] dependency manager.
* [minify][]: Command-line minification tool.

Steps:

1. [Install minify][].  Pre-built binaries and packages are available.  If you have [Go][] installed you can just run `go install github.com/tdewolff/minify/cmd/minify@latest`.
2. Run `bundle install` to install [Ruby][] dependencies ([Nokogiri][]).
3. Run `make` to scan `public/js` and regenerate `public/index.html`.
4. Load `public/index.html` and marvel at the chaos.

If you want to re-download the release page HTML and all versions of
[jQuery][], do the following:

1. Run `make fetch`.  This will download the release HTML and all versions of [jQuery][].
2. Run `make`.  This will scan `public/js/` and regenerate `public/index.html`.

## Notes

You may have trouble hosting this page if you have a restrictive
[Content-Security-Policy][] on your domain (like I do, and you should
too).  In particular, versions of [jQuery][] older than 1.4.0 will fail
to load.

The generated `index.html` sets a slightly more permissive
[Content-Security-Policy][] to work around this.

By the way, you really shouldn't self-host the generated page because it
deliberately serves up old versions of [jQuery][] with known security
vulnerabilities.

## License

[MIT][].  See `license.txt`.

[site]: https://pablotron.github.io/jqueries/
  "Release version of this site."
[jquery]: https://jquery.com/
  "jQuery"
[go]: https://go.dev/
  "Go programming language."
[minify]: https://github.com/tdewolff/minify
  "Command-line minifier."
[ruby]: https://ruby-lang.org/
  "Ruby programming language."
[bundler]: https://bundler.io/
  "Ruby dependency manager."
[install minify]: https://github.com/tdewolff/minify/tree/master/cmd/minify
  "minify installation instructions."
[you might not need jquery]: https://youmightnotneedjquery.com/
  "You might not need jQuery."
[transitive dependencies]: https://en.wikipedia.org/wiki/Transitive_dependency
  "Transitive dependency"
[mit]: https://opensource.org/licenses/MIT
  "MIT license"
[content-security-policy]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy
  "Content security policy"
