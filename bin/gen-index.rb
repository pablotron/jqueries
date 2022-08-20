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

        <ul>
          <li>
            <a
              href='https://github.com/pablotron/jqueries'
              title='github repo'
              aria-label='github repo'
            >github repo</a>
          </li>

          <li>
            <a
              href='https://youmightnotneedjquery.com/'
              title='you might not need jquery'
              aria-label='you might not need jquery'
            >you might not need jquery</a>
          </li>
        </ul>

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

scripts = Dir[GLOB].sort.map { |s|
  name = File.basename(s)
  { name: name, url: 'js/%s' % [name] }
}

puts T[:html] % {
  rows: scripts.map { |s| T[:tr] % s }.join,
}