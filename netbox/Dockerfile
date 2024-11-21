FROM docker.io/netboxcommunity/netbox:v4.1.6

RUN /opt/netbox/venv/bin/pip config set global.index-url https://mirrors.aliyun.com/pypi/simple \
    && /opt/netbox/venv/bin/pip install dulwich \
    && /opt/netbox/venv/bin/pip install netbox-qrcode \
    && /opt/netbox/venv/bin/pip install netbox-acls \
    && /opt/netbox/venv/bin/pip install netbox-plugin-dns \
    && /opt/netbox/venv/bin/pip install netbox-ipcalculator \
    && echo 'PLUGINS = ["netbox_qrcode","netbox_acls","netbox_dns", "netbox_ipcalculator"]' >> /etc/netbox/config/plugins.py \
    && SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" /opt/netbox/venv/bin/python3 /opt/netbox/netbox/manage.py collectstatic --no-input