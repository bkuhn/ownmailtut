# Dovecot

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

## Postfix authorization

Dovecot handles IMAP, but not authorized outgoing SMTP mail, which is
[explained in the postfix section](Postfix.md#Authorized-Outgoing-SMTP).

    unix_listener /var/spool/postfix/private/auth {
      group = postfix
      mode = 0660
      user = postfix
    }


