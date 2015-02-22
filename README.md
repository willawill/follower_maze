###README

To run this solution to the Follower Maze,

`ruby ./bin/run_server.rb`

```
   Usage: run_server [options]
        --log_level=LOGLEVEL         change the level of log
        --event_host=EVENTHOST       the host address for event listener
        --event_port=EVENTPORT       the port number for event listener
        --client_host=CLIENTHOST     the host adress for client listener
        --client_port=CLIENTPORT     the port number for client listener
    -h, --help                       display this screen
```

and in another terminal window run

`./bin/followermaze.sh`

To remove all the logging files,

`rake remove_logging_files`

##The Solution

This is a really simple solution. By having TCPServer within its own thread for clients to connect and a event to stream events in.

* Features
   1. Multi-thread. Client listener and Event listener are in their own thread.
   2  Configurable by command-line arguments.
   3. Developed with TDD fashion and unit tests covered.
   4. Logging system that handles `INFO`, `WARN` and `DEBUG`

* What's missing
   1. Integration test.
   2. Proper shutdown logging.
   3. Proper stess/load test.
   4. Deployment script.
   5. Good documentation