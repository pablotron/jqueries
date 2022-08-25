#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Download HTML from https://releases.jquery.com/jquery/ and write it to
# `bin/releases.html`.
#
# Note: `bin/releases.html` is parsed by `fetch-jqueries.rb`. 
#
# Usage:
#
#   bin/fetch-html.rb

# load libraries
require 'net/https'
require 'uri'

# jquery releases URL
URL = URI.parse('https://releases.jquery.com/jquery/')

# download HTML and write it to bin/releases.html
HTML = File.write(File.join(__dir__, 'releases.html'), Net::HTTP.get(URL))
