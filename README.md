# Web Framework
**Markdown-Generated Static Homepage with Possibility of Blog**

Provides a simple but robust template for a static webpage, for personal pursuits or as a personal homepage. Can be adapted to other uses.
## Getting Started
1. Fork/Clone this repository,
2. Create a page in `/pages/md/` as a `.md` file, ensuring it has an h1 tag (main heading),
3. Run the generation script in `/pages/` following the `how to generate the pages.txt` (run `ruby gen\ page\ html.rb` from `/pages`),
4. Modify `index.html` for your use, changing the top-level links and replacing templated regions.
## Features
- Markdown to HTML pages with generation script.
- Automatic table of contents generation for h2 and h3 level headings within the markdown, placing this underneath the h1 tag of the page.
- Generated html pages follow page template (can be adjusted).
- Tasteful design.
- No frills but nice.
- Prime ground for adaptation / a foundation to get started quickly.
- Could be adapted well for a blog/journal within the personal site.
## Notes 
1. Markdown files must start with an h1 tag. 
2. The pages are not designed with SEO in mind - this would not be hard to adapt for.
## Future Work / Extension
1. Automatically use markdown file name if no h1 tag is provided.
2. Adapt to use semantic tags, and improve SEO.
Pull-requests welcome.