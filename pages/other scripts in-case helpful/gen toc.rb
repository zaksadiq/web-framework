#!/usr/bin/env ruby
require 'nokogiri'

# Ensure a filename is provided
if ARGV.empty?
  puts "Usage: #{$0} file.html"
  exit 1
end

file = ARGV[0]
unless File.exist?(file)
  puts "File not found: #{file}"
  exit 1
end

# Parse the HTML
html = File.read(file)
doc  = Nokogiri::HTML(html)

# Build the TOC
p_tag = Nokogiri::XML::Node.new("p", doc)
p_tag['class'] = "table of contents"
p_tag.add_child("\n")  # newline after opening <p>

doc.css("h2, h3").each do |heading|
  next unless heading['id'] # skip if no id

  a_tag = Nokogiri::XML::Node.new("a", doc)
  a_tag['href']  = "##{heading['id']}"
  a_tag['class'] = "toc_#{heading.name}"
  a_tag.content  = heading.text.strip

  p_tag.add_child("  ")   # indent
  p_tag.add_child(a_tag)
  p_tag.add_child("\n")   # newline
end

puts p_tag.to_html