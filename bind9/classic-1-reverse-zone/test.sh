#!/usr/bin/env bash

set -x
set -e

# NS

dig @10.0.0.5 +noall +answer ns1.mydomain.net | grep -v -e '^$'
dig @10.0.0.5 +noall +answer ns1.mydomain.com | grep -v -e '^$'

# NS reverse

dig @10.0.0.5 +noall +answer -x 10.20.0.5 | grep -v -e '^$'
dig @10.0.0.5 +noall +answer -x 10.30.0.5 | grep -v -e '^$'

# A

dig @10.0.0.5 +noall +answer vm1.mydomain.net | grep -v -e '^$'
dig @10.0.0.5 +noall +answer vm2.mydomain.net | grep -v -e '^$'
dig @10.0.0.5 +noall +answer vm3.mydomain.net | grep -v -e '^$'

dig @10.0.0.5 +noall +answer vm1.mydomain.com | grep -v -e '^$'
dig @10.0.0.5 +noall +answer vm2.mydomain.com | grep -v -e '^$'
dig @10.0.0.5 +noall +answer vm3.mydomain.com | grep -v -e '^$'

# A reverse

dig @10.0.0.5 +noall +answer -x 10.20.0.11 | grep -v -e '^$'
dig @10.0.0.5 +noall +answer -x 10.20.0.12 | grep -v -e '^$'
dig @10.0.0.5 +noall +answer -x 10.20.0.13 | grep -v -e '^$'

dig @10.0.0.5 +noall +answer -x 10.30.0.11 | grep -v -e '^$'
dig @10.0.0.5 +noall +answer -x 10.30.0.12 | grep -v -e '^$'
dig @10.0.0.5 +noall +answer -x 10.30.0.13 | grep -v -e '^$'

# CNAME

dig @10.0.0.5 +noall +answer www.vm1.mydomain.net | grep -v -e '^$'

# MX

dig @10.0.0.5 +noall +answer mydomain.net MX | grep -v -e '^$'
dig @10.0.0.5 +noall +answer smtp.mydomain.net | grep -v -e '^$'

