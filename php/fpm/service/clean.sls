# vim: ft=sls

{#-
    Stops the PHP-FPM service and disables it at boot time.
#}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

PHP-FPM service is dead:
  service.dead:
    - name: {{ php.lookup.fpm.service.name.format(version=php.version) }}
    - enable: false
