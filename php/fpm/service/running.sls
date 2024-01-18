# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_file = tplroot ~ ".fpm.config.file" %}
{%- set sls_pools = tplroot ~ ".fpm.pools.present" %}
{%- set sls_ini = tplroot ~ ".fpm.ini.file" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_config_file }}
{%- if php.fpm.pools %}
  - {{ sls_pools }}
{%- endif %}
{%- if php.lookup.fpm.ini %}
  - {{ sls_ini }}
{%- endif %}

PHP-FPM service is running:
  service.running:
    - name: {{ php.lookup.fpm.service.name.format(version=php.version) }}
    - enable: true
    - watch:
      - sls: {{ sls_config_file }}
{%- if php.fpm.pools %}
      - sls: {{ sls_pools }}
{%- endif %}
{%- if php.lookup.fpm.ini %}
      - sls: {{ sls_ini }}
{%- endif %}
