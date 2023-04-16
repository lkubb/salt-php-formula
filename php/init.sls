# vim: ft=sls

{#-
    *Meta-state*.

    This installs the php package,
    manages the php configuration file

#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - .package
  - .modules
  - .config
{%- if php.fpm.enable %}
  - .fpm
{%- endif %}
