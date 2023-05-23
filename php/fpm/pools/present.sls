# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".fpm.package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{%- if php.fpm.pools %}

PHP-FPM pools are managed:
  file.managed:
    - names:
{%-   for pool in php.fpm.pools %}
      - {{ php.lookup.fpm.pools.format(version=php.version) | path_join(pool ~ ".conf") }}:
        - context:
            pool_name: {{ pool }}
{%-   endfor %}
    - source: {{ files_switch(
                    ["pool.conf.j2"],
                    config=php,
                    lookup="PHP-FPM pools are managed",
                    use_subpath=true,
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - defaults:
        php: {{ php | json }}
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}
