###README

To run this solution to the follower_maze,

`ruby ./bin/run_server.rb`

```
   Usage: run_server [options]
        --log_level=LogLevel         change the level of log
        --event_host=EVENTHOST       the host address for event listener
        --event_prot=EVENTHOST       the port for event listener
        --client_host=CLIENTHOST     the host for event host address
        --client_port=CLIENTPORT     the host for event host address
    -h, --help                       Display this screen
```

and in another terminal window run

`./bin/followermaze.sh`

##The Solution

This is a really simple solution. By having TCPServer within its own thread for clients to connect and a event to stream events in.

* Features
   1. Multi-thread.
   2  Configurable by command-line arguments and environment variables
   3. Developed with TDD fashion and unit tests covered.
   4. Logging system that handles `INFO`, `WARN` and `DEBUG`

* What's missing
   1. Integration test.
   2. Proper shutdown.
   3. Proper stess/load test.
   4. Deployment script.
   5. Good documentation