# Any requests that continue for x seconds will be terminated and
# a stack trace output to the logs. The stack trace should help to
# determine what part of the application is causing the timeout.
Rack::Timeout.timeout = 15  # seconds
