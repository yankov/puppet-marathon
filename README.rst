Marathon Puppet Module
======================

Overview
--------

This Puppet module manages the Marathon framework for Apache Mesos.

Usage
-----

For managing Marathon:

.. code:: puppet

    class{'marathon':
      zookeeper  => 'zk://localhost:2181/mesos',
    }

Parameters
~~~~~~~~~~

-  ``zookeeper`` - Zookeeper quorum for Mesos masters -- **Required**
-  ``marathon_dir`` - Base directory for Marathon (default:
   ``/etc/marathon``)
-  ``conf_dir`` - Configuration directory for Marathon (default:
   ``/etc/marathon/conf``)
-  ``mesos_role`` - Mesos role that Marathon should use (default: none)
-  ``event_subscriber`` - event subscriber type: http\_callback,none
   (default: none)
-  ``http_endpoints`` - http endpoint to send event messages to
   (default: none)
-  ``task_launch_timeout`` - time, in milliseconds, to wait for a task
   before killing it (default: none)

File based configuration
------------------------

This module writes configuration parameters into files to be read by
Marathon. Given a key-value pair, the key becomes the filename and the
value becomes the file content.

Requirements
------------

-  Puppet >= 3.5.1

Dependencies
------------

-  `apt <https://forge.puppetlabs.com/puppetlabs/apt>`__ version
   ``>= 1.0.0``
-  `mesos <https://forge.puppetlabs.com/deric/mesos>`__ version
   ``>= 0.6.2``
-  `stdlib <https://forge.puppetlabs.com/puppetlabs/stdlib>`__ version
   ``>= 4.2.0``

Links
-----

For more information see `Marathon
project <http://mesosphere.github.io/marathon/>`__

License
-------

Apache License 2.0

.. |Puppet Forge| image:: http://img.shields.io/puppetforge/v/potto/marathon.svg
   :target: https://forge.puppetlabs.com/potto/marathon
.. |Build Status| image:: https://travis-ci.org/potto007/puppet-marathon.png
   :target: https://travis-ci.org/potto007/puppet-marathon
