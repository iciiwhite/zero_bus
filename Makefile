# © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

.PHONY: all clean

all: ebin/zero_bus.app priv/zero_bus_nif.so

priv/zero_bus_nif.so: c_src/zero_bus_nif.cc c_src/hypervisor_asm.asm
	mkdir -p priv
	nasm -f elf64 c_src/hypervisor_asm.asm -o c_src/hypervisor_asm.o
	g++ -std=c++17 -fPIC -shared -o priv/zero_bus_nif.so c_src/zero_bus_nif.cc c_src/hypervisor_asm.o -I include -lerl_interface -lei

ebin/zero_bus.app:
	erlc -o ebin src/zero_bus.app.src

ebin/zero_bus.beam: src/zero_bus.erl
	erlc -o ebin src/zero_bus.erl

ebin/zero_bus_sup.beam: src/zero_bus_sup.erl
	erlc -o ebin src/zero_bus_sup.erl

ebin/zero_bus_ipc.beam: src/zero_bus_ipc.erl
	erlc -o ebin src/zero_bus_ipc.erl

all: ebin/zero_bus.beam ebin/zero_bus_sup.beam ebin/zero_bus_ipc.beam ebin/zero_bus.app

clean:
	rm -rf ebin priv c_src/*.o