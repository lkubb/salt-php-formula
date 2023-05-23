# vim: ft=sls

{#-
    Removes all managed PHP-FPM pools.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

{%- if php.fpm.pools %}

PHP-FPM pools are absent:
  file.absent:
    - names:
{%-   for pool in php.fpm.pools %}
      - {{ php.lookup.fpm.pools.format(version=php.version) | path_join(pool ~ ".conf") }}
{%-   endfor %}
{%- endif %}
