# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- set sls_fpm_clean = tplroot ~ '.fpm.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_config_clean }}
{%- if php.fpm.enable %}
  - {{ sls_fpm_clean }}
{%- endif %}
  - {{ slsdotpath }}.repo.clean

php-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ php.lookup.pkg.php.format(version=php.version) }}
    - require:
      - sls: {{ sls_config_clean }}
{%- if php.fpm.enable %}
      - sls: {{ sls_fpm_clean }}
{%- endif %}
