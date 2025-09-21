#!/bin/bash
# Simple About page checker for TechCon 2024

echo "=== Checking About Page ==="
cd ~/Desktop/TechCon_HTML

# 1) Check file existence
if [ -f about.html ]; then
  echo "✅ about.html exists"
else
  echo "❌ about.html MISSING"
fi

# 2) Check <h1>
grep -q "<h1>About TechCon 2024" about.html && echo "✅ <h1> correct" || echo "❌ <h1> missing"

# 3) Check nav links
for link in index.html schedule.html register.html contact.html; do
  grep -q "href=\"$link\"" about.html && echo "✅ link to $link found" || echo "❌ link to $link missing"
done

# 4) Check main and articles
grep -q "<main" about.html && echo "✅ <main> found" || echo "❌ <main> missing"
ARTCOUNT=$(grep -o "<article" about.html | wc -l)
echo "Number of <article> tags: $ARTCOUNT"

# 5) Check images and alt attributes
IMGCOUNT=$(grep -o "<img" about.html | wc -l)
echo "Number of <img> tags: $IMGCOUNT"
awk 'BEGIN{RS=">";IGNORECASE=1}/<img/{if($0!~ /alt=/) print "❌ MISSING ALT: "$0}' about.html || true

# 6) Check existence of referenced images
for img in images/history.jpg images/mission.jpg images/jane-smith.jpg images/john-doe.jpg; do
  [ -f "$img" ] && echo "✅ $img exists" || echo "❌ $img missing"
done

# 7) Git status
echo "=== Git status ==="
git status --porcelain
