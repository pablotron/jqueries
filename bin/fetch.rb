#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Download all versions of jquery and write them to public/js.
#
# Usage:
#   bin/fetch.rb

require 'net/https'
require 'nokogiri'
require 'uri'

CSS = 'a[href*=".min."]'

# load html
HTML = File.read(File.join(__dir__, 'releases.html'))
# HTML = Net::HTTP.get(URI.parse('https://releases.jquery.com/jquery/'))

# parse html, get minified uris, fetch uris in threads
uris = (Nokogiri::HTML(HTML) / CSS).map { |e|
  URI.parse(e['href']) # parse uri
}.select { |uri|
  # require https prefix, exclude migrate
  (uri.scheme == 'https') && !uri.path.match(/migrate/)
}.map do |uri|
  Thread.new(uri) do |s|
    # build destination path
    dst = File.join(__dir__, '..', 'public', 'js', File.basename(uri.path))

    # write data
    File.write(dst, Net::HTTP.get(uri))
  end
end.each { |t| t.join }
