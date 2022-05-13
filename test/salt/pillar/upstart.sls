# -*- coding: utf-8 -*-
# vim: ft=yaml
---
php:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value
    enablerepo:
      stable: true
    config: '/etc/php.ini'
    fpm:
      config: /etc/php/{version}/fpm/php-fpm.conf
    cli:
      ini: /etc/php/{version}/cli/conf.d/50-salt.ini
    fpm:
      config: /etc/php/{version}/fpm/php-fpm.conf
      ini: /etc/php/{version}/fpm/conf.d/50-salt.ini
      pool_defaults:
        group: www-data
        listen: /run/php/fpm-{name}.sock
        listen.group: www-data
        listen.owner: www-data
        pm: dynamic
        pm.max_children: 5
        pm.max_spare_servers: 3
        pm.min_spare_servers: 1
        pm.start_servers: 2
        user: www-data
      pools: /etc/php/{version}/fpm/pool.d
      service:
        name: php{version}-fpm
        unit: /etc/systemd/system/{name}.service.d/override.conf
    pkg:
      default: php{version}-{name}
      fpm: php{version}-fpm
      php: php{version}
    repos_req_pkgs: []
  cli:
    ini: {}
  config: {}
  fpm:
    config:
      error_log: /var/log/php{version}-fpm.log
      pid: /run/php/php{version}-fpm.pid
    enable: true
    ini: {}
    pools: {}
    remove_default_pool: true
    service:
      harden: true
      requires_mount: []
      wants: []
  module_install_recommends: false
  modules: []
  use_external_repo: true
  version: '8.1'

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://php/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   php-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      php-config-file-file-managed:
        - 'example.tmpl.jinja'
      php-fpm-config-file-file-managed:
        - 'fpm-example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
