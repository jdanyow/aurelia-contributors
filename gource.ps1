mkdir aurelia
cd aurelia

$repos = "animator-css", "animator-velocity", "app-contacts", "beginner-kits", "benchmarks", "binding", "bootstrapper", "bootstrapper-webpack", "bundler", "cache", "cli", "dependency-injection", "dialog", "documentation", "event-aggregator", "fetch-client", "framework", "history", "history-browser", "html-import-template-loader", "html-template-element", "http-client", "i18n", "loader", "loader-default", "loader-webpack", "logging", "logging-console", "metadata", "pal", "pal-browser", "pal-nodejs", "pal-worker", "path", "polyfills", "registry", "route-recognizer", "router", "skeleton-navigation", "skeleton-plugin", "task-queue", "templating", "templating-binding", "templating-resources", "templating-router", "testing", "tools", "ui-virtualization", "validation", "validatejs", "web-components", "webpack-plugin"

Remove-Item .\*.txt

Foreach($repo in $repos)
{
  git clone https://github.com/aurelia/$repo
  gource --output-custom-log "$repo.temp1" "$repo"
  get-content "$repo.temp1" | %{$_ -replace "/","-"} | Set-Content "$repo.temp2"
  get-content "$repo.temp2" | %{$_ -replace "(.+\|.+\|.+)\|-(.+)","`$1|/$repo/`$2"} | Set-Content "$repo.txt"
  Remove-Item "$repo.temp1"
  Remove-Item "$repo.temp2"
}

Get-Content .\*.txt | Out-File combined.temp
Get-Content combined.temp | Sort | Set-Content aurelia.txt
Remove-Item combined.temp

cd ..

node captions.js aurelia/aurelia.txt

gource -1280x720 -o gource.ppm --seconds-per-day 0.04 aurelia/aurelia.txt --hide "filenames,dirnames" --dir-name-depth 1 --highlight-users --caption-file captions.txt --caption-size 32 --caption-duration 2 --logo logo-medium.png --logo-offset 1070x650
C:\ffmpeg\bin\ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i gource.ppm -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 aurelia-contributers.x264.mp4

# cleanup
Remove-Item gource.ppm
Remove-Item captions.txt
Remove-Item -Recurse -Force aurelia