# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
{%- if php.lookup.pkg_manager in ['apt', 'dnf', 'yum', 'zypper'] %}
  - {{ slsdotpath }}.install
{%- elif salt['state.sls_exists'](slsdotpath ~ '.' ~ php.lookup.pkg_manager) %}
  - {{ slsdotpath }}.{{ php.lookup.pkg_manager }}
{%- else %}
  []
{%- endif %}
