# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{%- if php.config %}

Global php.ini is managed:
  file.managed:
    - name: {{ php.lookup.config.format(version=php.version) }}
    - source: {{ files_switch(['php.ini.j2'],
                              lookup='Global php.ini is managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        php: {{ php | json }}
        lookup_key: "config"
{%- endif %}

{%- if php.cli.ini %}

CLI php.ini is managed:
  file.managed:
    - name: {{ php.lookup.cli.ini.format(version=php.version) }}
    - source: {{ files_switch(['php.ini.j2'],
                              lookup='CLI php.ini is managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        php: {{ php | json }}
        lookup_key: "cli:ini"
{%- endif %}
