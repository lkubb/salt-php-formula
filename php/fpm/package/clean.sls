# vim: ft=sls

{#-
    Removes PHP-FPM and service overrides and has a
    dependency on `php.fpm.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".fpm.config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_config_clean }}

PHP-FPM service overrides are removed:
  file.absent:
    - name: {{ php.lookup.fpm.service.unit.format(name=php.lookup.fpm.service.name.format(version=php.version)) }}

PHP-FPM is removed:
  pkg.removed:
    - name: {{ php.lookup.pkg.fpm.format(version=php.version) }}
    - require:
      - sls: {{ sls_config_clean }}
