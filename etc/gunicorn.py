from os import environ
if 'OPENSHIFT_PATTON_IP' in environ:
    bind = "%s:%s" %(environ['OPENSHIFT_PATTON_IP'], environ['OPENSHIFT_PATTON_PORT'])
else:
    bind = "0.0.0.0:50009"

if 'OPENSHIFT_PATTON_RUN_DIR' in environ:
    pidfile = '%s/gunicorn.pid' %(environ['OPENSHIFT_PATTON_RUN_DIR'],)
daemon=False
max_requests = 1000 
timeout = 600
preload=True
secure_scheme_headers = {'X-FORWARDED-PROTO': 'https'}
worker_class = 'sync'
# worker_connections = 250
workers = 5

