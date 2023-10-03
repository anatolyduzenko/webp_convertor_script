#!/usr/bin/ruby
gem 'ffi'
gem 'webp-ffi'

require 'ffi'
require 'webp-ffi'

def convert_image(src, opts = {})
   puts "Started new image (#{src}) encoding at: #{Time.now}"
   filename = File.expand_path(File.join(File.dirname(__FILE__), "./source/#{src}"))
   out_filename = File.expand_path(File.join(File.dirname(__FILE__), "./encoded/#{src}.webp"))
   WebP.encode(filename, out_filename, opts)
end


puts "Started At #{Time.now}"
files_to_convert = Dir.entries("./source").select { |f| File.file? File.join("./source", f) }

files_to_convert.each do |file_name|
   t = Thread.new{convert_image(file_name, [{quality: 75, method: 6}])}
   t.join
end

puts "End at #{Time.now}"