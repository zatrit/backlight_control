CC = gcc
CFLAGS += -Wall -Wextra -O3 -march=native

prefix = /usr/local
backlight_dir = /sys/class/backlight
vendor_backlight_dir = $(backlight_dir)/$(shell ls $(backlight_dir) | head -n1)
max_brightness = $(shell cat $(vendor_backlight_dir)/max_brightness)

DEFINES += -D BRIGHTNESS_FILE=\"$(vendor_backlight_dir)/brightness\"
DEFINES += -D MAX_BRIGHTNESS=$(max_brightness)

all: backlightctl

%: %.c
	$(CC) $(CFLAGS) $(DEFINES) $< -o $@

clean:
	rm -f backlightctl

install: backlightctl
	install -D -m 4755 -o root -g root $< $(DESTDIR)$(prefix)/bin/$<

uninstall:
	rm -f $(DESTDIR)$(prefix)/bin/backlightctl
