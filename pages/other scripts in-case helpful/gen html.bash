# In-case it comes in handy.
# Must be run from same directory as file.
for f in ./md/*.md; do
    filename=$(basename "$f" .md)
    pandoc -s "$f" --template=./template.html -o "./html/${filename}.html"
done