# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_php_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_php_install }}

PHP-FPM is installed:
  pkg.installed:
    - name: {{ php.lookup.pkg.fpm.format(version=php.version) }}
    - require:
      - sls: {{ sls_php_install }}

{%- if php.fpm.remove_default_pool %}

PHP-FPM default www pool is removed:
  file.absent:
    - name: {{ php.lookup.fpm.pools.format(version=php.version) | path_join("www.conf") }}
    - onchanges:
      - PHP-FPM is installed
{%- endif %}

PHP-FPM service overrides are installed:
  file.managed:
    - name: {{ php.lookup.fpm.service.unit.format(name=php.lookup.fpm.service.name.format(version=php.version)) }}
    - source: {{ files_switch(['php-fpm.service.conf.j2'],
                              lookup='PHP-FPM service overrides are installed',
                              use_subpath=True
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        php: {{ php | json }}
    - require:
      - PHP-FPM is installed
{%- if 'systemctl' | which %}
  # this executes systemctl daemon-reload
  module.run:
    - service.systemctl_reload: []
    - onchanges:
      - file: {{ php.lookup.fpm.service.unit.format(name=php.lookup.fpm.service.name.format(version=php.version)) }}
{%- endif %}
