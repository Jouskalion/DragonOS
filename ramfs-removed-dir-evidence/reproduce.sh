#!/bin/sh
B=${1:-/bin/busybox}
b=$($B mktemp -d /tmp/ramfs-cwd.XXXXXX) || exit 2
$B mount -t ramfs none "$b" || exit 2
$B mkdir "$b/gone" || exit 2
cd "$b/gone" || exit 2
$B rmdir "$b/gone" || exit 2
$B stat -c 'links=%h' .
$B touch ghost
echo TOUCH_RC=$?
$B mkdir child
echo MKDIR_RC=$?
$B ls -la
cd /
$B umount "$b"
$B rmdir "$b"
