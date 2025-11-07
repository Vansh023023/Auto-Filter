FROM python:3.8-slim-buster

RUN apt update && apt upgrade -y
RUN apt install git ntpdate -y
COPY requirements.txt /requirements.txt

RUN cd /
RUN pip3 install -U pip && pip3 install -U -r requirements.txt
RUN mkdir /EvaMaria
WORKDIR /EvaMaria
COPY start.sh /start.sh

# Sync system time on container startup
RUN echo '#!/bin/bash
ntpdate -s time.nist.gov
exec /bin/bash /start.sh' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
