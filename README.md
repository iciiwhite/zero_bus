# IciiZeroBus

A Zero-Trust Inter-Process Communication Bus with Hardware-Grade Isolation.

# Overview

IciiZeroBus combines Erlang’s actor model with a custom hypervisor layer (Intel VT‑x / ARM TrustZone) to enforce physical memory isolation between communicating processes. Every message travels through a dedicated, non‑shareable transport, guaranteeing that a compromised node cannot read or tamper with traffic outside its designated enclave.

## Requirements

* x86‑64 CPU with VMX and EPT support (or ARM with TrustZone)
* Linux kernel with headers
* Erlang/OTP 25+
* NASM
* GCC / Clang with C++17 support

### Build

```shell
make
```

This compiles the hypervisor kernel module, the Erlang NIF shared object, and the OTP application.

### Run

Start the Erlang node with appropriate privileges:

```shell
sudo erl -pa ebin -s zero_bus start
```

The bus service will initialise the hardware isolation ring and listen for IPC commands.

## License

See [LICENSE](license)