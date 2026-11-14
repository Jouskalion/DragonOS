#!/bin/sh
set -eu
b=$(busybox mktemp -d /tmp/ramfs-live.XXXXXX)
busybox mount -t ramfs none "$b"
printf 'payload\n' > "$b/source"
busybox ln "$b/source" "$b/alias"
test "$(busybox stat -c %h "$b/source")" = 2
echo PASS_LIVE_HARDLINK
busybox mkdir "$b/dir"
busybox mv "$b/alias" "$b/dir/moved"
test "$(busybox cat "$b/dir/moved")" = payload
echo PASS_LIVE_RENAME
busybox rm "$b/dir/moved"
busybox rmdir "$b/dir"
test "$(busybox stat -c %h "$b/source")" = 1
echo PASS_LIVE_UNLINK
busybox umount "$b"
busybox rmdir "$b"
echo LIVE_CONTROLS_COMPLETE
