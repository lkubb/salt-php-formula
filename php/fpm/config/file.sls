# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".fpm.package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

PHP-FPM config is managed:
  file.managed:
    - name: {{ php.lookup.fpm.config.format(version=php.version) }}
    - source: {{ files_switch(
                    ["php-fpm.conf.j2"],
                    config=php,
                    lookup="PHP-FPM config is managed",
                    use_subpath=true,
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - context:
        php: {{ php | json }}
    - require:
      - sls: {{ sls_package_install }}
