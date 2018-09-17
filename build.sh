#!/bin/bash

set -x

CC="gcc -g3 -Wall -O0 -undef -nostdinc -fno-builtin "
CC="$CC -I./opt -I./freebsd/sys -DKERNEL -DINET -DTCPDEBUG"
# CC="$CC -I./opt -I./freebsd/sys -finstrument-functions "

mkdir -p objs
rm -rf objs/*.o objs/*.a objs/test_*

$CC -c freebsd/kern/kern_subr.c -o objs/kern_subr.o
$CC -c freebsd/kern/uipc_domain.c -o objs/uipc_domain.o
$CC -c freebsd/kern/uipc_mbuf.c -o objs/uipc_mbuf.o
$CC -c freebsd/kern/uipc_socket.c -o objs/uipc_socket.o
$CC -c freebsd/kern/uipc_socket2.c -o objs/uipc_socket2.o
#$CC -c sys/kern/uipc_syscalls.c -o objs/uipc_syscalls.o
$CC -c freebsd/kern/sys_socket.c -o objs/sys_socket.o


$CC -c freebsd/net/if.c -o objs/if.o
$CC -c freebsd/net/if_ethersubr.c -o objs/if_ethersubr.o
$CC -c freebsd/net/if_loop.c -o objs/if_loop.o
$CC -c freebsd/net/radix.c -o objs/radix.o
$CC -c freebsd/net/route.c -o objs/route.o
$CC -c freebsd/netinet/if_ether.c -o objs/if_ether.o
$CC -c freebsd/netinet/igmp.c -o objs/igmp.o
$CC -c freebsd/netinet/in.c -o objs/in.o
$CC -c freebsd/netinet/in_cksum.c -o objs/in_cksum.o
$CC -c freebsd/netinet/in_pcb.c -o objs/in_pcb.o
$CC -c freebsd/netinet/in_proto.c -o objs/in_proto.o

$CC -c freebsd/netinet/ip_icmp.c -o objs/ip_icmp.o
$CC -c freebsd/netinet/ip_input.c -o objs/ip_input.o
$CC -c freebsd/netinet/ip_output.c -o objs/ip_output.o
$CC -c freebsd/netinet/raw_ip.c -o objs/raw_ip.o

$CC -c freebsd/netinet/tcp_debug.c -o objs/tcp_debug.o
$CC -c freebsd/netinet/tcp_input.c -o objs/tcp_input.o
$CC -c freebsd/netinet/tcp_output.c -o objs/tcp_output.o
$CC -c freebsd/netinet/tcp_subr.c -o objs/tcp_subr.o
$CC -c freebsd/netinet/tcp_timer.c -o objs/tcp_timer.o
$CC -c freebsd/netinet/tcp_usrreq.c -o objs/tcp_usrreq.o

$CC -c freebsd/netinet/udp_usrreq.c -o objs/udp_usrreq.o
