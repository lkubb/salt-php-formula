# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
{%- if php.fpm.enable %}
  - .fpm.clean
{%- endif %}
  - .config.clean
  - .modules.clean
  - .package.clean
