# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

php-fpm-service-clean-service-dead:
  service.dead:
    - name: {{ php.lookup.fpm.service.name.format(version=php.version) }}
    - enable: False
