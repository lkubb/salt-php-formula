# vim: ft=sls

{#-
    Installs PHP-FPM, manages its configuration including
    pools and php.ini and starts/enables the PHP-FPM service.
#}

include:
  - .package
  - .config
  - .pools
  - .ini
  - .service
