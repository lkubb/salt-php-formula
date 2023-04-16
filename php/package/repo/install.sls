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

{%-     if php.lookup.repos[reponame].get("keyring") %}

PHP {{ reponame }} signing key is available:
  file.managed:
    - name: {{ php.lookup.repos[reponame].keyring.file }}
    - source: {{ files_switch([salt["file.basename"](php.lookup.repos[reponame].keyring.file)],
                          lookup="PHP " ~ reponame ~ " signing key is available")
              }}
      - {{ php.lookup.repos[reponame].keyring.source }}
    - source_hash: {{ php.lookup.repos[reponame].keyring.source_hash }}
    - user: root
    - group: {{ php.lookup.rootgroup }}
    - mode: '0644'
    - dir_mode: '0755'
    - makedirs: true
{%-     endif %}

PHP {{ reponame }} repository is available:
  pkgrepo.managed:
{%-     for conf, val in php.lookup.repos[reponame].items() %}
{%-       if conf != "keyring" and conf is not none %}
    - {{ conf }}: {{ val }}
{%-       endif %}
{%-     endfor %}
{%-     if php.lookup.pkg_manager in ["dnf", "yum", "zypper"] %}
    - enabled: 1
{%-     endif %}
    - require_in:
      - PHP is installed

{%-   else %}

{%-     if php.lookup.repos[reponame].get("keyring") %}

PHP {{ reponame }} signing key is absent:
  file.absent:
    - name: {{ php.lookup.repos[reponame].keyring.file }}
{%-     endif %}

PHP {{ reponame }} repository is disabled:
  pkgrepo.absent:
{%-     for conf in ["name", "ppa", "ppa_auth", "keyid", "keyid_ppa", "copr"] %}
{%-       if conf in php.lookup.repos[reponame] and php.lookup.repos[reponame][conf] is not none %}
    - {{ conf }}: {{ php.lookup.repos[reponame][conf] }}
{%-       endif %}
{%-     endfor %}
    - require_in:
      - PHP is installed
{%-   endif %}
{%- endfor %}
