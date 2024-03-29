# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

include:
  - {{ sls_package_install }}

{%- if php.modules %}

PHP modules are installed:
  pkg.installed:
    - pkgs:
{%-   for mod in php.modules %}
{%-     if php.lookup.pkg.get(mod) | is_list %}
{%-       for pkg in php.lookup.pkg[mod] %}
      - {{ pkg.format(version=php.version) }}
{%-       endfor %}
{%-     else %}
      - {{ php.lookup.pkg.get(mod, php.lookup.pkg.default.format(name=mod, version=php.version)).format(version=php.version) }}
{%-     endif %}
{%-   endfor %}
    - install_recommends: {{ php.module_install_recommends }}
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}

{%- if php.extra_pkgs %}

Extra package dependencies are installed:
  pkg.installed:
    - pkgs: {{ php.extra_pkgs }}
    - install_recommends: {{ php.module_install_recommends }}
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}
