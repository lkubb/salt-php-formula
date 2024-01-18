# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}

# There is no need for python-apt anymore.

{%- if php.lookup.repos_req_pkgs %}

Required packages to use PHP repository are installed:
  pkg.installed:
    - pkgs: {{ php.lookup.repos_req_pkgs | json }}
{%- endif %}

{%- set enable_crb_epel = [] %}
{%- for reponame, enabled in php.lookup.enablerepo.items() %}
{%-   if enabled is none %}
{%-     continue %}
{%-   elif enabled %}
{%-     if "remi" in reponame %}
{%-       do enable_crb_epel.append(true) %}
{%-     endif %}

PHP {{ reponame }} repository is available:

{%-     if "rpm" in php.lookup.repos[reponame] %}
  pkg.installed:
    - sources:
      - {{ php.lookup.repos[reponame].rpm.name }}: {{ php.lookup.repos[reponame].rpm.url }}

{%-     else %}
  pkgrepo.managed:
{%-     for conf, val in php.lookup.repos[reponame].items() %}
    - {{ conf }}: {{ val }}
{%-     endfor %}
{%-     if php.lookup.pkg_manager in ["dnf", "yum", "zypper"] %}
    - enabled: 1
{%-     endif %}
{%-     endif %}
    - require_in:
      - PHP is installed

{%-   else %}

PHP {{ reponame }} repository is disabled:
{%-     if "rpm" in php.lookup.repos[reponame] %}
  pkg.removed:
    - name: {{ php.lookup.repos[reponame].rpm.name }}
{%-     else %}
  pkgrepo.absent:
{%-       for conf in ["name", "ppa", "ppa_auth", "keyid", "keyid_ppa", "copr"] %}
{%-         if conf in php.lookup.repos[reponame] %}
    - {{ conf }}: {{ php.lookup.repos[reponame][conf] }}
{%-         endif %}
{%-       endfor %}
    - require_in:
      - PHP is installed
{%-     endif %}
{%-   endif %}
{%- endfor %}

{%- if grains.os_family == "RedHat" and enable_crb_epel and grains.os != "Fedora" %}

CRB and EPEL repos are enabled:
  pkg.installed:
    - name: epel-release
    - require_in:
      - PHP is installed

{%- if grains.os == "Rocky" %}
  cmd.run:
    - name: crb enable
    - unless:
      - crb status | grep 'is enabled'

{%- elif grains.os == "AlmaLinux" %}
  cmd.run:
    - name: dnf config-manager --set-enabled crb
    - unless:
      - dnf repolist --enabled | grep -e '^crb'
{%- endif %}
    - require_in:
      - PHP is installed
{%- endif %}
