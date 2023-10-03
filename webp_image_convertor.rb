#!/usr/local/bin/ruby

require 'ffi'
require 'webp-ffi'

src_dir = if ARGV[0].nil? then 'source' else ARGV[0] end
dst_dir = if ARGV[1].nil? then 'encoded' else ARGV[1] end
quality = if ARGV[2].nil? then 80 else ARGV[2] end

def convert_image(file, src_dir = 'source', dst_dir = 'encoded', opts = {})
   puts "Started new image (#{file}) encoding"
   filename = File.expand_path(File.join(File.dirname(__FILE__), "/#{src_dir}/#{file}"))
   ext = File.extname(filename)
   dest = File.basename(filename, ext)
   Dir.mkdir(dst_dir) unless File.exist?(dst_dir)
   return if ext == '.gif'
   out_filename = File.expand_path(File.join(File.dirname(__FILE__), "/#{dst_dir}/#{dest}.webp"))
   WebP.encode(filename, out_filename, *opts)
end

puts "Started At #{Time.now}"
files_to_convert = Dir.entries("./#{src_dir}").select { |f| File.file? File.join("./#{src_dir}", f) }

files_to_convert.each do |file_name|
   t = Thread.new{convert_image(file_name, src_dir, dst_dir, [{quality: quality, method: 6}])}
   t.join
end

puts "End at #{Time.now}"