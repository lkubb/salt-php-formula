# vim: ft=sls

{#-
    Removes the PHP-FPM configuration.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

php fpm config is absent:
  file.absent:
    - name: {{ php.lookup.fpm.config.format(version=php.version) }}
