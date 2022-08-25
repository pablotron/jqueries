#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Scan public/js/jquery-*.js and generate index.html.
#
# Usage:
#   ruby % | minify --type html > public/index.html
#

# script globs
GLOB = File.join(__dir__, '..', 'public', 'js', 'jquery-*.js')

# reference links
REFS = [{
  name: 'github repo',
  href: 'https://github.com/pablotron/jqueries',
  help: 'github repo',
}, {
  name: 'you might not need jquery',
  href: 'https://youmightnotneedjquery.com/',
  help: 'you might not need jquery',
}, {
  name: 'my site',
  href: 'https://pablotron.org/',
  help: 'my site',
}]

# templates
T = {
  html: %{
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset='utf-8'/>

        <!-- unsafe-eval and unsafe-inline are needed for older jquery -->
        <meta
          http-equiv='Content-Security-Policy'
          content="script-src 'self' 'unsafe-eval' 'unsafe-inline'"
        />
        <title>jqueries</title>

        <link rel='stylesheet' type='text/css' href='style.min.css'/>
        <script type='text/javascript' src='js/script.min.js' defer></script>
      </head>

      <body>
        <h1>jqueries</h1>

        <p>
          Every version of <a href='https://jquery.com/' title='jQuery'
          aria-label='jQuery'>jQuery</a> on the same page.
        </p>

        <p>
          The tooltip and value of the <code>version</code> column in
          each row of the table below comes from code executed by the
          corresponding version of <a href='https://jquery.com/'
          title='jQuery' aria-label='jQuery'>jQuery</a>.
        </p>

        <p>
          <b>References</b>
        </p>

        <ul>%<refs>s</ul>

        <table>
          <thead>
            <tr>
              <th title='path to file'>path</th>
              <th title='jquery version'>version</th>
            </tr>
          </thead>

          <tbody>
            %<rows>s
          </tbody>
        </table>
      </body>
    </html>
  }.strip.gsub(/\s+/m, ' ').gsub(/>\s+</m, '><'),

  ref: %{
    <li>
      <a
        href='%<href>s'
        title='%<help>s'
        aria-label='%<help>s'
      >%<name>s</a>
    </li>
  },

  tr: %{
    <tr data-path='%<url>s'>
      <td
        title='path to file'
        aria-label='path to file'
        class='path'
      >
        <a
          title='path to file'
          aria-label='path to file'
          href='%<url>s'
        >%<name>s</a>
      </td>

      <td
        title='jquery version'
        aria-label='jquery version'
        class='data'
      >n/a</td>
    </tr>
  },
}

# load scripts
scripts = Dir[GLOB].sort.map { |s|
  name = File.basename(s)
  { name: name, url: 'js/%s' % [name] }
}

# generate html, write to standard output
puts T[:html] % {
  rows: scripts.map { |s| T[:tr] % s }.join,
  refs: REFS.map { |r| T[:ref] % r }.join,
}
