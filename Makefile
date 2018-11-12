PROJECT = emqx_auth_username
PROJECT_DESCRIPTION = EMQ X Authentication with Username/Password
PROJECT_VERSION = 3.0

BUILD_DEPS = emqx cuttlefish
dep_emqx = git https://github.com/emqx/emqx emqx30
dep_cuttlefish = git https://github.com/emqx/cuttlefish emqx30

NO_AUTOPATCH = cuttlefish

ERLC_OPTS += +debug_info

TEST_ERLC_OPTS += +debug_info

COVER = true

include erlang.mk

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_auth_username.conf -i priv/emqx_auth_username.schema -d data

rebar-deps:
	rebar3 as test get-deps

rebar-compile: rebar-deps
	rebar3 as test compile

rebar-ct: rebar-deps
	make -C _build/test/lib/cuttlefish
	_build/test/lib/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_auth_username.conf -i priv/emqx_auth_username.schema -d data
	rebar3 as test ct
