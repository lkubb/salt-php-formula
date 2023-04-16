# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

# There is no need for python-apt anymore.

{%- if php.lookup.repos_req_pkgs %}

Required packages to use PHP repository are installed:
  pkg.installed:
    - pkgs: {{ php.lookup.repos_req_pkgs | json }}
{%- endif %}

{%- for reponame, enabled in php.lookup.enablerepo.items() %}
{%-   if enabled %}

PHP {{ reponame }} repository is available:
  pkgrepo.managed:
{%-     for conf, val in php.lookup.repos[reponame].items() %}
    - {{ conf }}: {{ val }}
{%-     endfor %}
{%-     if php.lookup.pkg_manager in ["dnf", "yum", "zypper"] %}
    - enabled: 1
{%-     endif %}
    - require_in:
      - PHP is installed

{%-   else %}

PHP {{ reponame }} repository is disabled:
  pkgrepo.absent:
{%-     for conf in ["name", "ppa", "ppa_auth", "keyid", "keyid_ppa", "copr"] %}
{%-       if conf in php.lookup.repos[reponame] %}
    - {{ conf }}: {{ php.lookup.repos[reponame][conf] }}
{%-       endif %}
{%-     endfor %}
    - require_in:
      - PHP is installed
{%-   endif %}
{%- endfor %}
