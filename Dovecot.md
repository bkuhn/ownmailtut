# Dovecot

## Postfix authorization

Dovecot handles IMAP, but not authorized outgoing SMTP mail, which is
[explained in the postfix section](Postfix.md#Authorized-Outgoing-SMTP).

    unix_listener /var/spool/postfix/private/auth {
      group = postfix
      mode = 0660
      user = postfix
    }

