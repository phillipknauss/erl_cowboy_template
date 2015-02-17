%% @doc Handler for / endpoints
-module(web_root_handler).

-export(
  [ init/2
  , allowed_methods/2
  , content_types_accepted/2
	, content_types_provided/2
  , resource_exists/2
  , terminate/3
  ]).

-export(
  [ handle_post/2
  , handle_get/2]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COWBOY CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
init(Req, Opts) ->
	{cowboy_rest, Req, Opts}.

allowed_methods(Req, State) -> {[<<"GET">>, <<"POST">>], Req, State}.

content_types_provided(Req, State) -> {[
	{{<<"application">>, <<"json">>, []}, handle_get}
], Req, State}.

content_types_accepted(Req, State) ->
  {[{<<"application/json">>, handle_post}], Req, State}.

resource_exists(Req, State) -> {true, Req, State}.

terminate(_Reason, _Req, _State) -> ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INTERNAL CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handle_post(Req, State) ->
  {ok, _Body, Req1} = cowboy_req:body(Req),

			% Put stuff here

	{true, Req1, State}. 

handle_get(Req, State) ->
  {<<"Yay!">>, Req, State}.

