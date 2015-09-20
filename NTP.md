# Network Time Protocol Daemon

Postfix in particular needs a very precise clock.  But, generally speaking, a
mail server should always have the correct time.

Network Time Protocol (NTP) is the preferred way to keep a mail server's
clock correct.  Two reasonable NTP daemons packages exist in Debian:
`openntpd` and `ntp`.  You can `aptitude install` either one, and by default,
both packages configure to use the [Debian NTP](https://wiki.debian.org/NTP)
pool of servers.  The default configuration should work fine.

To check that the NTP daemon is working for `openntpd`, look in
/var/log/syslog such as:

     ntpd[680]: adjusting clock frequency by AMOUNT

To check that the NTP daemon is working for `ntp`, use the command:

     /usr/bin/ntpq -p
