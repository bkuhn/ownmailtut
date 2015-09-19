# My Own Mail Server Tutorial

This tutorial explains to someone who is generally skilled in basic GNU/Linux
administration (Debian in particular) how to configure a mail server using
Postfix, SpamAssassin, Dovecot, and Pigeonhole (for sieve filtering).

## Who Is This Tutorial For?

This tutorial is likely for you if the following criteria are true for you:

* You prefer to run your own mail server and do not want your email
  controlled by a third-party service provider that could go away someday, or
  change configuration of the mail server in a way you don't like without
  your consent.

* Your mail server won't have too many users.  This tutorial leaves you with
  a system at the end that is not terribly trivial to add and remove users
  quickly.

* You have basic sysadmin skills and you can continue to do basic sysadmin
  tasks on the system.
