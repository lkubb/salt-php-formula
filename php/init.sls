# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - .package
  - .modules
  - .config
{%- if php.fpm.enable %}
  - .fpm
{%- endif %}
