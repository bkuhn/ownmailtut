# Dovecot

## SSL Configuration

Take the
[SSL certificate for the server that you previously generated](PrepWork.md#ssl-certificate)
and place it in a file named `/etc/ssl/certs/2015-example-org.pem`.

Since this is the private key, take care that not just any user can read the
file.  One way to solve that problem, is to set  permissions to 0440 on this
file, and put the file in a group allowed to read it:

    # chown root.ssl-cert /etc/ssl/certs/2015-example-org.pem
    # chmod 440 /etc/ssl/certs/2015-example-org.pem

## Postfix authorization

Dovecot handles IMAP, but not authorized outgoing SMTP mail, which is
[explained in the postfix section](Postfix.md#Authorized-Outgoing-SMTP).

    unix_listener /var/spool/postfix/private/auth {
      group = postfix
      mode = 0660
      user = postfix
    }


