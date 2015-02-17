# erl_cowboy_template
Starting point for web projects in Erlang using Cowboy

I've done this quite a few times, so with this project there's no need to start from scratch. We have erlang+rebar+reltool set up to use a multi-application project structure, and a web project with cowboy hosting both static assets and a minimal initial rest handler.

To use (from project root):

1. Get dependencies (if you don't have them)

```` ./rebar get-deps ````

2. Compile

```` ./rebar compile ````

3. Generate release

```` ./rebar generate ````

4. Run or console

```` rel/web/bin/web start ````

or

```` rel/web/bin/web console ````

## Known issues:

1. Warning is shown in console when ./rebar generate - WARN: 'generate' command does not apply to directory ./
