/*
 * © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
 */

#ifndef ZERO_BUS_NIF_H
#define ZERO_BUS_NIF_H

#include <erl_nif.h>

extern int hypervisor_init(void);
extern int hypervisor_send(const unsigned char *dest, const unsigned char *payload, size_t len);

#endif