# vim: ft=sls

{#-
    *Meta-state*.

    Undoes everything performed in the ``php`` meta-state
    in reverse order, i.e.
    removes the configuration file and then
    uninstalls the package.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
{%- if php.fpm.enable %}
  - .fpm.clean
{%- endif %}
  - .config.clean
  - .modules.clean
  - .package.clean
