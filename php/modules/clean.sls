# vim: ft=sls

{#-
    Removes PHP module packages.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

{%- if php.modules %}

PHP modules are absent:
  pkg.removed:
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
{%- endif %}
