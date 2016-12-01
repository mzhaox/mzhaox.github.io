# Preliminary inotifywait script to compile all Markdown/TeX files
# in the current directory.

inotifywait -m -e close_write,moved_to,create . |
while read -r directory events filename; do
  filename=$(basename "$filename")
  ext="${filename##*.}"
  filename="${filename%.*}"
  if [ $ext = "md" ] || [ $ext = "tex" ]; then
    pandoc -s $filename.$ext -o $filename.html --mathjax --css pandoc.css
  fi
done
