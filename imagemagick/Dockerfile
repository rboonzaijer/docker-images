FROM roelscript/img:alpine

USER root

RUN apk add --no-cache --update \
    imagemagick \
    ghostscript

# Enable ghostscript permissions
# https://www.kb.cert.org/vuls/id/332928/
# https://www.imagemagick.org/script/security-policy.php
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="PS" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="PS2" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="PS3" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="EPS" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="PDF" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml
RUN sed -i 's|</policymap>|  <policy domain="coder" rights="read\|write" pattern="XPS" />\n</policymap>|g' /etc/ImageMagick-7/policy.xml

USER appuser

CMD ["/bin/sh"]
