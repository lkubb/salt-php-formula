# vim: ft=sls

{#-
    Starts the PHP-FPM service and enables it at boot time.
    Has a dependency on `php.fpm.config`_, `php.fpm.ini`_
    and `php.fpm.pools`_.
#}

include:
  - .running
