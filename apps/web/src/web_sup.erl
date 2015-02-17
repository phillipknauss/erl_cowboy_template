-module(web_sup).

-behaviour(supervisor).

-export([start_link/0, start_listeners/0]).
-export([init/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ADMIN API
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, {}).

start_listeners() ->
  {ok, Port} = application:get_env(http_port),
  {ok, ListenerCount} = application:get_env(http_listener_count),

  Dispatch =
    cowboy_router:compile(
      [ {'_',
          [
						{<<"/">>, web_root_handler, []},
						%{<<"/">>, cowboy_static, {priv_file, web, "assets/index.html"}},
						{<<"/[...]">>, cowboy_static, {priv_dir, web, "assets"}}
          ]
        }
      ]),

  RanchOptions =
    [ {port, Port}
    ],
  CowboyOptions =
    [ {env,       [{dispatch, Dispatch}]}
    , {compress,  true}
    , {timeout,   12000}
    ],
  
  cowboy:start_http(web_http, ListenerCount, RanchOptions, CowboyOptions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BEHAVIOUR CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
init({}) ->
  ok = pg2:create(web_listeners),
  
  {ok, { {one_for_one, 5, 10},
    [ {web_http,
        {web_sup, start_listeners, []},
        permanent, 1000, worker, [web_sup]}
    ]}
  }.
