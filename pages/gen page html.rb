#!/usr/bin/env ruby
require 'fileutils'
require 'nokogiri'

# Directories
md_dir = "./md"
output_dir = "./html"
template = "./template.html"

# Ensure output directory exists
FileUtils.mkdir_p(output_dir)

# Process all Markdown files
Dir.glob("#{md_dir}/*.md") do |md_file|
  filename = File.basename(md_file, ".md")
  output_file = File.join(output_dir, "#{filename}.html")

  # 1️⃣ Convert Markdown to HTML using Pandoc
  # -s = standalone, --template = template, no default TOC (we'll insert manually)
  cmd = "pandoc -s \"#{md_file}\" --template=\"#{template}\" -o \"#{output_file}\""
  puts "Converting #{md_file} → #{output_file}"
  system(cmd)

  # 2️⃣ Open the generated HTML with Nokogiri
  html_content = File.read(output_file)
  doc = Nokogiri::HTML(html_content)

  # 3️⃣ Build the TOC under the first <h1>
  h1 = doc.at_css("h1")
  if h1
    div_tag = Nokogiri::XML::Node.new("div", doc)
    div_tag['class'] = "toc"
    div_tag.add_child("\n")  # newline

    toc_heading = Nokogiri::XML::Node.new("h2", doc)
    toc_heading.content = "Table of Contents"
    div_tag.add_child(toc_heading)
    div_tag.add_child("\n")  # newline

    doc.css("h2, h3").each do |heading|
      next unless heading['id'] # skip if no id

      a_tag = Nokogiri::XML::Node.new("a", doc)
      a_tag['href']  = "##{heading['id']}"
      a_tag['class'] = "toc_#{heading.name}"
      a_tag.content  = heading.text.strip

      div_tag.add_child("  ")   # indent
      div_tag.add_child(a_tag)
      div_tag.add_child("\n")
    end

    # Insert the TOC right after the first <h1>
    h1.add_next_sibling(div_tag)
  end

  # 4️⃣ Write back the modified HTML
  File.write(output_file, doc.to_html)
end

puts "All Markdown files converted with TOC inserted under <h1>."