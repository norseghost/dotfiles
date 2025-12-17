if [ $(tty) = "/dev/tty1" ]; then
    sway  2>&1 > /tmp/sway.log
    exit 0
fi
