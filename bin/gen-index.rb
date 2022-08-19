#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Scan files in ./js and generate index.html.
#
# Usage:
#   ruby % | minify --type html > public/index.html
#

# script globs
GLOB = File.join(__dir__, '..', 'public', 'js', '*.js')

# templates
T = {
  html: %{
    <DOCTYPE html>
    <html>
      <head>
        <meta charset='utf-8'/>
        <title>jqueries</title>

        <style type='text/css'>
          body {
            background-color: #fff;
            font-family: arial, helvetica, sans-serif;
            padding: 1em 2em 1em 2em;
          }

          table { margin-top: 2em }
        </style>

        <script type='text/javascript'>
          const J = {};
        </script>

        %<js>s
      </head>

      <body>
        <h1>jqueries</h1>

        <p id='intro'>
          Every version of <a href='https://jquery.com/' title='jQuery'
          aria-label='jQuery'>jQuery</a> on the same page.  The value of
          the <code>version</code> column in the table below comes from
          the corresponding version of jQuery.
        </p>

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

        <script type='text/javascript'>
          const HIS = ['greetings', 'aloha', 'yo', 'hi', 'hello', 'howdy', 'sup'];
          const css = (path) => `tr[data-path="${path}"] .data`;
          const hi = (version) => `
            ${HIS[Math.floor(Math.random() * HIS.length)]}
            from
            ${version}
          `;

          for (let path in J) {
            /* grab jquery and version */
            let jq = J[path];
            const v = jq.fn.jquery;

            /* use given version of jquery to set attr and text */
            jq(css(path)).attr('title', v).text(hi(v));
          }
        </script>
      </body>
    </html>
  }.strip.gsub(/\s+/m, ' ').gsub(/>\s+</m, '><'),

  js: %{
    <script src='%<url>s'></script>
    <script>
      J['%<url>s'] = $.noConflict(true);
    </script>
  }.strip,

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
        >%<url>s</a>
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
  { path: s, url: 'js/%s' % [File.basename(s)] }
}

puts T[:html] % {
  js: scripts.map { |s| T[:js] % { url: s[:url] } }.join,
  rows: scripts.map { |s| T[:tr] % { url: s[:url] } }.join,
}
