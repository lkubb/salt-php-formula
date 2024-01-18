# vim: ft=sls

{#-
    This state will remove the configured php repository.
    This works for apt/dnf/yum/zypper-based distributions only by default.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as php with context %}


{%- if php.lookup.pkg_manager not in ["apt", "dnf", "yum", "zypper"] %}
{%-   if salt["state.sls_exists"](slsdotpath ~ "." ~ php.lookup.pkg_manager ~ ".clean") %}

include:
  - {{ slsdotpath ~ "." ~ php.lookup.pkg_manager ~ ".clean" }}
{%-   endif %}

{%- else %}
{%-   for reponame, enabled in php.lookup.enablerepo.items() %}
{%-     if enabled %}

PHP {{ reponame }} repository is absent:
{%-       if "rpm" in php.lookup.repos[reponame] %}
  pkg.removed:
    - name: {{ php.lookup.repos[reponame].name }}
{%-       else %}
  pkgrepo.absent:
{%-         for conf in ["name", "ppa", "ppa_auth", "keyid", "keyid_ppa", "copr"] %}
{%-           if conf in php.lookup.repos[reponame] %}
    - {{ conf }}: {{ php.lookup.repos[reponame][conf] }}
{%-           endif %}
{%-         endfor %}
{%-       endif %}
{%-     endif %}
{%-   endfor %}
{%- endif %}
