# Firehol

Firewalling seems to have fallen out of favor, but use of one has some
advantages.  One advantage is to ensure accidentally or newly installed
daemons, which may listen automatically on all network interfaces, do not
face the world immediately.  A properly configured server should only listen
on public interfaces with the daemons one wants on the public interface, but
not ever server is perfectly configured so a firewall provides, well, a
firewall to ensure configuration mistakes related to external-facing network
do not immediately propagate worldwide.

There are plenty of firewall generation systems; use one you know.  Follow
this tutorial for firehol on Debian.

## Upgrade to firehol 2 from testing

Debian 8 (jessie) included a 1.x version of firehol but
[firehol 2 supports IPv6](http://firehol.org/upgrade/#config-version-6), so
you'll have to pull firehol out of testing with:

    aptitude -t testing install firehol

