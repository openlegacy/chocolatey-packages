#! /usr/bin/env ruby

#
# Load OL project release data into template file and print to stdout
#

require "erb"
require "open-uri"
require 'optparse'

# parse arguments
options = {}
OptionParser.new do |parser|
  parser.on("-f", "--file PATH", "Require PATH to template file") do |f|
    options[:file] = f
  end
end.parse!

# set vars
template_path = options[:file]
project = ENV['OL_PROJECT_NAME']
version = ENV['OL_PROJECT_REVISION']
s3_bucket = ENV['OL_PROJECT_PUBLIC_BUCKET']

# evaluate data
url = "https://#{s3_bucket}.s3.amazonaws.com/#{project}/#{version}/windows/#{project}.zip"
sha_url = "https://#{s3_bucket}.s3.amazonaws.com/#{project}/#{version}/windows/#{project}.sha256"
sha_data = URI.parse(sha_url).read
sha256 = sha_data.split(" ").first  # get actual sha256 value

# inject data into template
template = File.read(template_path)
render = ERB.new(template)
puts render.result()
