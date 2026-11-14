#!/bin/sh
B=${1:-/bin/busybox}
export LC_ALL=C TZ=UTC
base=$($B mktemp -d /tmp/bb3-cli.XXXXXX) || exit 2
p=$base/m
$B mkdir "$p" || exit 2
$B mount -t tmpfs none "$p" || exit 2
printf 'original-mount\n' > "$p/marker"
$B umount "$p "
rc=$?
$B cat "$p/marker"
marker_rc=$?
echo "UMOUNT_EXIT=$rc MARKER_EXIT=$marker_rc"
$B umount "$p" 2>/dev/null
$B rmdir "$p" "$base"
[ "$rc" -ne 0 ] && [ "$marker_rc" -eq 0 ]
