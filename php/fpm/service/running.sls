# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.fpm.config.file' %}
{%- set sls_pools = tplroot ~ '.fpm.pools.present' %}
{%- set sls_ini = tplroot ~ '.fpm.ini.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_config_file }}
  - {{ sls_pools }}
  - {{ sls_ini }}

php-fpm-service-running-service-running:
  service.running:
    - name: {{ php.lookup.fpm.service.name.format(version=php.version) }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
      - sls: {{ sls_pools }}
      - sls: {{ sls_ini }}
