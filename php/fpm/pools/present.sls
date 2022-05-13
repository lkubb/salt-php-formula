# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.fpm.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{%- if php.fpm.pools %}

php-fpm-pools-present-file-managed:
  file.managed:
    - names:
{%-   for pool in php.fpm.pools %}
      - {{ php.lookup.fpm.pools.format(version=php.version) | path_join(pool ~ ".conf") }}:
        - context:
            pool_name: {{ pool }}
{%-   endfor %}
    - source: {{ files_switch(['pool.conf.j2'],
                              lookup='php-fpm-pools-present-file-managed',
                              use_subpath=True
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - defaults:
        php: {{ php | json }}
    - require:
      - sls: {{ sls_package_install }}
{%- endif %}
