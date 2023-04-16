Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``php``
^^^^^^^
*Meta-state*.

This installs the php package,
manages the php configuration file


``php.package``
^^^^^^^^^^^^^^^
Installs the php package only.


``php.package.install``
^^^^^^^^^^^^^^^^^^^^^^^



``php.package.repo``
^^^^^^^^^^^^^^^^^^^^
This state will install the configured php repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``php.config``
^^^^^^^^^^^^^^
Manages the php package configuration.
Has a dependency on `php.package`_.


``php.fpm``
^^^^^^^^^^^
Installs PHP-FPM, manages its configuration including
pools and php.ini and starts/enables the PHP-FPM service.


``php.fpm.config``
^^^^^^^^^^^^^^^^^^
Configures PHP-FPM and has a
dependency on `php.fpm.package`_.


``php.fpm.ini``
^^^^^^^^^^^^^^^
Manages the PHP-FPM php.ini and has a
dependency on `php.fpm.package`_.


``php.fpm.package``
^^^^^^^^^^^^^^^^^^^
Installs PHP-FPM and service overrides and has a
dependency on `php.package`_.


``php.fpm.pools``
^^^^^^^^^^^^^^^^^
Manages PHP-FPM pools and has a
dependency on `php.fpm.package`_.


``php.fpm.service``
^^^^^^^^^^^^^^^^^^^
Starts the PHP-FPM service and enables it at boot time.
Has a dependency on `php.fpm.config`_, `php.fpm.ini`_
and `php.fpm.pools`_.


``php.modules``
^^^^^^^^^^^^^^^
Installs PHP module packages.
Has a dependency on `php.package`_.


``php.clean``
^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``php`` meta-state
in reverse order, i.e.
removes the configuration file and then
uninstalls the package.


``php.package.clean``
^^^^^^^^^^^^^^^^^^^^^
Removes the php package.
Has a depency on `php.config.clean`_.


``php.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
This state will remove the configured php repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``php.config.clean``
^^^^^^^^^^^^^^^^^^^^
Removes the php package configuration.


``php.fpm.clean``
^^^^^^^^^^^^^^^^^
Undoes everything done in `php.fpm`_ in reverse order, i. e.
stops/disables the PHP-FPM service, removes its configuration
including managed pools and php.ini and removes the package.


``php.fpm.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^
Removes the PHP-FPM configuration.


``php.fpm.ini.clean``
^^^^^^^^^^^^^^^^^^^^^



``php.fpm.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^



``php.fpm.pools.clean``
^^^^^^^^^^^^^^^^^^^^^^^
Removes all managed PHP-FPM pools.


``php.fpm.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the PHP-FPM service and disables it at boot time.


``php.modules.clean``
^^^^^^^^^^^^^^^^^^^^^
Removes PHP module packages.


