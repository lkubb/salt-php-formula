# vim: ft=sls

{#-
    Removes the PHP-FPM php.ini.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

{%- if php.lookup.fpm.ini  %}

PHP-FPM php.ini is absent:
  file.absent:
    - name: {{ php.lookup.fpm.ini.format(version=php.version) }}
{%- endif %}
