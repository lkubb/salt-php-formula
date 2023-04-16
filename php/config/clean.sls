# vim: ft=sls

{#-
    Removes the php package configuration.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

PHP configuration is absent:
  file.absent:
    - names:
      - {{ php.lookup.config.format(version=php.version) }}
      - {{ php.lookup.cli.ini.format(version=php.version) }}
