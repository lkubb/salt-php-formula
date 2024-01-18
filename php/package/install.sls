# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ slsdotpath }}.repo

{%- if grains.os_family == "RedHat" %}
{%-   set module_name = "php:" %}
{%-   if php.lookup.repos.get("remi-modular") or php.lookup.repos.get("remi-all") %}
{%-     set module_name = module_name ~ "remi-" %}
{%-   elif php.lookup.repos.get("remi-safe") %} {#- No remi-modular means we don't use modules, just package names #}
{%-     set module_name = "" %}
{%-   endif %}
{%-   if module_name %}
{%-     set module_name = module_name ~ php.version %}

PHP DNF module is enabled:
  cmd.run:
    - name: >-
{%-     if salt["cmd.retcode"]("dnf module list --enabled php") %}
        dnf module -y enable {{ module_name }}
{%-     else %}
        dnf module -y switch-to {{ module_name }}
{%-     endif %}
    - unless:
      - dnf module list --enabled {{ module_name }}
{%-   endif %}
{%- endif %}

PHP is installed:
  pkg.installed:
    - name: {{ php.lookup.pkg.php.format(version=php.version) }}
