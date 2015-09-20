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

## Configure firehol

[`/etc/firehol/firehol.conf`](etc/firehol/firehol.conf) contains the primary
configuration for firehol.
[Firehol's website contains detailed documentation](http://firehol.org/documentation/),
but an email server does require a complicated configuration.  Below,
consider a few of the important lines from this configuration:

* This line is important, as `version 6` is the version of the firehol settings
  that support IPv6.

* Lines of the form:

        variable="service service"

  are variable settings that can be used later.  The example file provided
  here has one variable, `public_services` that is not used, and is simply
  kept around as a "reference" to remember what other protocols can be added.

* Variables of the form:

        server_NAME_ports
        client_NAME_ports

  are to create special services that firehol does not yet know about.  For a
  mail server, the only protocol unknown to firehol is the
  [sieve service](Sieve).

* The main section of `interface any world` lists the rules for all
  interfaces facing out ot the world.  The primary lines for allowing all the
  key outward-facing mail services configured on this server are:

        server imaps accept
        server smtp accept
        server submission accept
        server sieve accept

  (SSH is similar allowed from everywhere with `server ssh accept`, which
  perhaps is more open than some would prefer.)

* SMTP clients are accepted, which is on port 25.  Note that smtps has been
  generally depreciated, and the [postfix documentation](Postfix.md) explains
  how to ensure `STARTTLS` is supported on port 25.

* The variable `allowed_outgoing_services_to_any` is used to list those
  services that permitted as outgoing clients.  `dns` absolutely must appear
  on this list for any server (like this one) that lives publicly on the
  Internet.  `ntp` is a good idea, as postfix likes a clock set well
  ([ntpd configuration details are also in this tutorial](NTP.md)).  `http`
  and `https` likely aren't strictly necessary, but downloads of URLs won't
  work otherwise (such as on the command line with `wget`).

* Add IP numbers to `allow_outgoing_ssh_ips` to allow ssh connections
  *outgoing* from this server to another host.

## Enable Firehol On Boot

Two settings are changed in [etc/default/firehol](etc/default/firehol) from
the default. `START_FIREHOL` is set to `YES` so that firehol will launch
automatically when the system boots.  With this setting, ensure
`WAIT_FOR_IFACE` is set to the external-network-facing interface.  In many
situations, this is `eth0`.



