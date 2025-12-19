# SSHtty gateway

This small Alpine-based Docker container gets old telnet-only devices connected to SSH hosts.

I built this to connect to [SDF Public Access Unix](https://sdf.org) from my Wyse dumb terminal, which is hooked up to a Lantronix UDS-10. These little terminal server devices are quite cheap on eBay. Paired with a little gateway like this, it gets you *on line* without the fuss of ARM SoCs or USB-to-serial converters of dubious quality.


## Security

**For the love of all that is good and holy** note that there is **ZERO** encryption or authentication on the telnet side of this container. Telnet is plain text.

It is up to you to determine whether to put a password on your SSH key, should you chose to mount one to `/home/gateway/.ssh`. If you do not, anyone with telnet access to this container will have free access to the destination account. If you do, anyone sniffing the LAN will soon find out said password.

Also, do note the imperfect input sanitization. You won't be able to `user@host; rm -rf /`, but a clever person may be able to find something else.
