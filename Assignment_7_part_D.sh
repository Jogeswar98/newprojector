#!/bin/bash


if [ $# -ne 3 ]; then
    echo "Usage: $0 <repo_url> <days> <output_format>"
    exit 1
fi

repo_url=$1
days=$2
output_format=$3
report_file="commit_report.$output_format"


tmp_dir=$(mktemp -d)
git clone "$repo_url" "$tmp_dir" >/dev/null 2>&1
cd "$tmp_dir" || exit


if [ "$output_format" == "csv" ]; then
    echo "Commit ID,Author,Email,Message,Files Changed" > "$report_file"
    git log --since="$days days ago" --pretty=format:"%H,%an,%ae,%s" --name-only |
    awk 'NF{print $0}' >> "$report_file"
    echo "CSV report generated: $report_file"


elif [ "$output_format" == "html" ]; then
    echo "<html><body><h2>Commit Report</h2><table border='1'>" > "$report_file"
    echo "<tr><th>Commit ID</th><th>Author</th><th>Email</th><th>Message</th><th>Files Changed</th></tr>" >> "$report_file"
    git log --since="$days days ago" --pretty=format:"<tr><td>%H</td><td>%an</td><td>%ae</td><td>%s</td></tr>" --name-only |
    awk 'NR>1{print "<tr><td colspan=\"4\"></td><td>"; print $0; print "</td></tr>"} END {print "</table></body></html>"}' >> "$report_file"
    echo "HTML report generated: $report_file"
else
    echo "Invalid format. Choose csv or html."
fi


cd - >/dev/null
rm -rf "$tmp_dir"

