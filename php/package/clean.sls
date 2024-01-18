# vim: ft=sls

{#-
    Removes the php package.
    Has a dependency on `php.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- set sls_fpm_clean = tplroot ~ ".fpm.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_config_clean }}
{%- if php.fpm.enable %}
  - {{ sls_fpm_clean }}
{%- endif %}
  - {{ slsdotpath }}.repo.clean

{%- if grains.os_family == "RedHat" %}
{%-   set module_name = "php:" %}
{%-   if php.lookup.repos.get("remi-modular") or php.lookup.repos.get("remi-all") %}
{%-     set module_name = module_name ~ "remi-" %}
{%-   elif php.lookup.repos.get("remi-safe") %} {#- No remi-modular means we don't use modules, just package names #}
{%-     set module_name = "" %}
{%-   endif %}
{%-   if module_name %}

PHP DNF module is removed and reset:
  cmd.run:
    - name: dnf -y module remove {{ module_name }} && dnf -y module reset {{ module_name }}
    - onlyif:
      - dnf module list --enabled {{ module_name }}
{%-   endif %}
{%- endif %}

PHP is removed:
  pkg.removed:
    - name: {{ php.lookup.pkg.php.format(version=php.version) }}
    - require:
      - sls: {{ sls_config_clean }}
{%- if php.fpm.enable %}
      - sls: {{ sls_fpm_clean }}
{%- endif %}
