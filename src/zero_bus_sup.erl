%% © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

-module(zero_bus_sup).
-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Child = #{id       => zero_bus_ipc,
              start    => {zero_bus_ipc, start_link, []},
              restart  => permanent,
              shutdown => 5000,
              type     => worker,
              modules  => [zero_bus_ipc]},
    {ok, {#{strategy => one_for_one, intensity => 1, period => 5}, [Child]}}.