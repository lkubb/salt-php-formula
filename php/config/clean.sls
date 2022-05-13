# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

php-config-clean-file-absent:
  file.absent:
    - names:
      - {{ php.lookup.config.format(version=php.version) }}
      - {{ php.lookup.cli.ini.format(version=php.version) }}
