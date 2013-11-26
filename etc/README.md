
Environment Configuration
-------------------------

Place project-specific environmental configurations in the file
etc/project-environment.sh.


Supervisor Configuration
------------------------

Using the Procfile is the preferred method to specify
background tasks for a project. However, in rare circumstances
it may be necessary to do direct configuration of supervisor.
Files ending in .conf may be placed in etc/supervisor.d to be
loaded by supervisord at startup.
