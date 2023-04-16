# vim: ft=sls

{#-
    Undoes everything done in `php.fpm`_ in reverse order, i. e.
    stops/disables the PHP-FPM service, removes its configuration
    including managed pools and php.ini and removes the package.
#}

include:
  - .service.clean
  - .ini.clean
  - .pools.clean
  - .config.clean
  - .package.clean
