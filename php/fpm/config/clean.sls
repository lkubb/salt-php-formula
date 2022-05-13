# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

php-fpm-config-clean-file-absent:
  file.absent:
    - name: {{ php.lookup.fpm.config.format(version=php.version) }}
