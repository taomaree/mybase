FROM ubuntu:18.10

ENV TZ=Asia/Shanghai DEBIAN_FRONTEND=noninteractive

RUN groupmod -g 99 nogroup && usermod -u 99 -g 99 nobody \
    && echo $TZ > /etc/timezone \
    && mkdir -p ~/.pip && echo [global] > ~/.pip/pip.conf && echo "index-url = https://pypi.mirrors.ustc.edu.cn/simple" >> ~/.pip/pip.conf \
    && apt-get update && apt-get install -y ca-certificates curl wget \
    && sed -i 's@ .*.ubuntu.com@ https://mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && echo registry=http://npmreg.mirrors.ustc.edu.cn/ > ~/.npmrc \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends software-properties-common ca-certificates \
     curl wget net-tools jq iputils-ping iputils-arping socat netcat telnet dnsutils bind9utils traceroute mtr tzdata vim \
     ttf-dejavu runit cron logrotate rsyslog-kafka dumb-init gosu  \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && sed -i 's/^module(load="imklog"/#module(load="imklog"/g' /etc/rsyslog.conf \
    && mkdir -p /etc/service/cron /etc/service/syslog \
    && bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/cron -f" > /etc/service/cron/run' \
    && bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/rsyslogd -n" > /etc/service/syslog/run' \
    && chmod 755 /etc/service/cron/run /etc/service/syslog/run

CMD ["runsvdir", "/etc/service"]
