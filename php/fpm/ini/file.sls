# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".fpm.package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

PHP-FPM php.ini is managed:
  file.managed:
    - name: {{ php.lookup.fpm.ini.format(version=php.version) }}
    - source: {{ files_switch(["php.ini.j2"],
                              lookup="PHP-FPM php.ini is managed",
                              use_subpath=True
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - context:
        lookup_key: 'fpm:ini'
        php: {{ php | json }}
    - require:
      - sls: {{ sls_package_install }}
