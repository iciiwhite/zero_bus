/*
 * © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
 */

#include "zero_bus_nif.h"
#include <cstring>

static int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info) {
    if (hypervisor_init() != 0) return 1;
    return 0;
}

static ERL_NIF_TERM send_nif(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    if (argc != 2) return enif_make_badarg(env);
    ErlNifBinary dest, payload;
    if (!enif_inspect_binary(env, argv[0], &dest)) return enif_make_badarg(env);
    if (!enif_inspect_binary(env, argv[1], &payload)) return enif_make_badarg(env);
    int rc = hypervisor_send(dest.data, payload.data, payload.size);
    return enif_make_int(env, rc);
}

static ErlNifFunc nif_funcs[] = {
    {"send", 2, send_nif}
};

ERL_NIF_INIT(zero_bus_nif, nif_funcs, load, NULL, NULL, NULL)