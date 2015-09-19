# Package Installation

This configuration was done for Debian GNU/Linux 8 (aka jessie).
Instructions for most Debian, Debian-based and Debian-derived systems should
work roughly similarly, but these instructions were only tested on jessie.

Install the basic operating system to start, of course, and the you want the
following packages:

     # aptitude install postfix postgrey dovecot postfix-policyd-spf-python

## SRS Support From testing

At the time of writing, jessie did not have the `postsrsd` package, so you'll
need to put `testing` in your apt sources somehow.  You can do this in any
matter you're comfortable with as a Debian user, but I did it this way:

0. Create
   [`/etc/apt/sources.list.d/testing.list`](etc/apt/sources.list.d/testing.list),
   as seen in this repository.

1. Create [`/etc/apt/sources.list.d/testing.list`](etc/apt/sources.list.d/testing.list),
   as seen in this repository.

2. Run:
        aptitude update
        aptitude -t testing install postsrsd
