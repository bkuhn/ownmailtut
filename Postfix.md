# Postfix Configuration

## Authorized Outgoing SMTP

## Greylisting

### Configuring postgrey

You likely want to configure
[`/etc/default/postgrey`](etc/default/postgrey).  The item I often change
most importantly is putting in place the FQDN of the mail server and set the
time.

Note that the line in [`/etc/postfix/main.cf`](etc/postfix/main.cf) that
calls out to the postgrey server is:

    smtpd_recipient_restrictions =
        ....,
        check_policy_service inet:127.0.0.1:10023

## SPF

### Configuring SPF Policy Daemon

There are a few choices for an SPF policy daemon in Debian.  This tutorial
focuses on `postfix-policyd-spf-python`.

This was installed as part of the
[main package installation](PackagineInstallation.md#package-installation).




