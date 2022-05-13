# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ slsdotpath }}.repo

php-package-install-pkg-installed:
  pkg.installed:
    - name: {{ php.lookup.pkg.php.format(version=php.version) }}
