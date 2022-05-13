# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}


{%- if php.lookup.pkg_manager not in ['apt', 'dnf', 'yum', 'zypper'] %}
{%-   if salt['state.sls_exists'](slsdotpath ~ '.' ~ php.lookup.pkg_manager ~ '.clean') %}

include:
  - {{ slsdotpath ~ '.' ~ php.lookup.pkg_manager ~ '.clean' }}
{%-   endif %}

{%- else %}
{%-   for reponame, enabled in php.lookup.enablerepo.items() %}
{%-     if enabled %}
{%-       if php.lookup.repos[reponame].get("keyring") %}

PHP {{ reponame }} signing key is absent:
  file.absent:
    - name: {{ php.lookup.repos[reponame].keyring.file }}
{%-       endif %}

PHP {{ reponame }} repository is absent:
  pkgrepo.absent:
{%-       for conf in ['name', 'ppa', 'ppa_auth', 'keyid', 'keyid_ppa', 'copr'] %}
{%-         if conf in php.lookup.repos[reponame] and php.lookup.repos[reponame][conf] is not none %}
    - {{ conf }}: {{ php.lookup.repos[reponame][conf] }}
{%-         endif %}
{%-       endfor %}
{%-     endif %}
{%-   endfor %}
{%- endif %}
