# Dovecot

[Dovecot](http://wiki.dovecot.org/FrontPage) is an IMAP server.  This
tutorial explains how to configure Dovecot for a small group of users with
basic authentication and SSL support.

## Basic Authentication

Dovecot supports many
[complex authentication mechanisms](http://wiki2.dovecot.org/Authentication/Mechanisms),
this tutorial does not discuss their configuration.

Thus, the only change needed for authentication is in
[`/etc/dovecot/conf.d/10-auth.conf`](etc/dovecot/conf.d/10-auth.conf) as follows:

    auth_mechanisms = plain login

which allows the login authentication mechanism.

By default, the Dovecot package in Debian uses PAM authentication against the
normal system login system.  This is already enabled automatically via the
file included by
[`/etc/dovecot/conf.d/10-auth.conf`](etc/dovecot/conf.d/10-auth.conf), called
`auth-system.conf.ext`.  Make no changes to that file; the Debian settings
handles the PAM authentication.

## SSL Configuration

Take the
[SSL third-party signed certificate for the server that you previously generated](PrepWork.md#ssl-certificate)
and place it in a file named `/etc/ssl/certs/2015-example-org.pem`.

While this is basically public information, nothing we configure requires the
file to be world-readable, so we set it only group-readable:

    # chown root.ssl-cert /etc/ssl/certs/2015-example-org.pem
    # chmod 440 /etc/ssl/certs/2015-example-org.pem

You will also need to put the the private key in place as well, such as in a
file named `/etc/ssl/private/2015-example-org-private.key`.  Definitely take
care that not just any user can read the file, so making it only readable by
the `ssl-cert` group is important:

    # chown root.ssl-cert /etc/ssl/private/2015-example-org-private.key
    # chmod 440 /etc/ssl/private/2015-example-org-private.key

Next, add the following settings to
[`/etc/dovecot/conf.d/10-ssl.conf`](etc/dovecot/conf.d/10-ssl.conf):

    ssl = yes
    ...
    ssl_cert = </etc/ssl/certs/2015-example-org.pem
    ssl_key = </etc/ssl/private/2015-example-org-private.key

## Mail Storage Location

Dovecot will operate as the Mail Delivery Agent (MDA) as well as the IMAP
server.  Thus (more or less), only Dovecot needs to know where the mail
ultimately lives with the
[`mail_location`](http://wiki.dovecot.org/MailLocation) in
[`/etc/dovecot/conf.d/10-mail.conf`](etc/dovecot/conf.d/10-mail.conf).  The
following setting:

    mail_location = maildir:~/Mail:INBOX=~/Mail/INBOX:LAYOUT=fs

does a few things.  First, it says that each user's inbox will be in their
home directory, in `~/Mail/INBOX` instead of the default location (in
`/var/mail`).

More importantly, `LAYOUT=fs` assures that subfolders in IMAP are also
[subfolders on the disk](http://wiki.dovecot.org/MailboxFormat/Maildir#Directory_Structure).
This is mostly a matter of taste.


## Postfix authorization

Dovecot handles IMAP, but not authorized outgoing SMTP mail, which is
[explained in the postfix section](Postfix.md#Authorized-Outgoing-SMTP).

    unix_listener /var/spool/postfix/private/auth {
      group = postfix
      mode = 0660
      user = postfix
    }


