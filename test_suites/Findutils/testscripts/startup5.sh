rm -rf tmpdir
mkdir tmpdir
touch tmpdir/$(date --date="today" +"%Y-%m-%d") -t $(date --date="today" +"%y%m%d%H%M")
touch tmpdir/$(date --date="yesterday" +"%Y-%m-%d") -t $(date --date="yesterday" +"%y%m%d%H%M")
touch tmpdir/$(date --date="2 days ago" +"%Y-%m-%d") -t $(date --date="2 days ago" +"%y%m%d%H%M")
touch tmpdir/$(date --date="3 days ago" +"%Y-%m-%d") -t $(date --date="3 days ago" +"%y%m%d%H%M")
touch tmpdir/$(date --date="4 days ago" +"%Y-%m-%d") -t $(date --date="4 days ago" +"%y%m%d%H%M")
