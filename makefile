CC = gcc
CFLAGS = -g3 -ggdb -Wall -O0 -Werror=implicit-function-declaration

BINS := test_init test_pigeon test_self test_tun

OBJDIR := objs

SRCS= \
	freebsd/kern/kern_descrip.c      \
	freebsd/kern/kern_event.c        \
	freebsd/kern/kern_fail.c         \
	freebsd/kern/kern_khelp.c        \
	freebsd/kern/kern_hhook.c        \
	freebsd/kern/kern_linker.c       \
	freebsd/kern/kern_mbuf.c         \
	freebsd/kern/kern_module.c       \
	freebsd/kern/kern_mtxpool.c      \
	freebsd/kern/kern_ntptime.c      \
	freebsd/kern/kern_osd.c          \
	freebsd/kern/kern_sysctl.c       \
	freebsd/kern/kern_tc.c           \
	freebsd/kern/kern_uuid.c         \
	freebsd/kern/link_elf.c          \
	freebsd/kern/md5c.c              \
	freebsd/kern/subr_capability.c   \
	freebsd/kern/subr_counter.c      \
	freebsd/kern/subr_eventhandler.c \
	freebsd/kern/subr_kobj.c         \
	freebsd/kern/subr_lock.c         \
	freebsd/kern/subr_module.c       \
	freebsd/kern/subr_param.c        \
	freebsd/kern/subr_pcpu.c         \
	freebsd/kern/subr_sbuf.c         \
	freebsd/kern/subr_taskqueue.c    \
	freebsd/kern/subr_unit.c         \
	freebsd/kern/sys_capability.c    \
	freebsd/kern/sys_generic.c       \
	freebsd/kern/sys_socket.c        \
	freebsd/kern/uipc_accf.c         \
	freebsd/kern/uipc_mbuf.c         \
	freebsd/kern/uipc_mbuf2.c        \
	freebsd/kern/uipc_domain.c       \
	freebsd/kern/uipc_sockbuf.c      \
	freebsd/kern/uipc_socket.c       \
	freebsd/kern/uipc_syscalls.c \
    freebsd/net/if.c \
    freebsd/net/if_ethersubr.c \
    freebsd/net/if_loop.c \
    freebsd/net/radix.c \
    freebsd/net/route.c \
    freebsd/netinet/if_ether.c \
    freebsd/netinet/igmp.c \
    freebsd/netinet/in.c \
    freebsd/netinet/in_cksum.c \
    freebsd/netinet/in_pcb.c \
    freebsd/netinet/in_proto.c \
    freebsd/netinet/ip_icmp.c \
    freebsd/netinet/ip_input.c \
    freebsd/netinet/ip_output.c \
    freebsd/netinet/raw_ip.c \
    freebsd/netinet/tcp_debug.c \
    freebsd/netinet/tcp_input.c \
    freebsd/netinet/tcp_output.c \
    freebsd/netinet/tcp_subr.c \
    freebsd/netinet/tcp_timer.c \
    freebsd/netinet/tcp_usrreq.c \
    freebsd/netinet/udp_usrreq.c \
	lib/handshake.c \
    lib/if_pigeon.c \
    lib/if_tun.c \
    lib/ip_intercept.c \
    lib/init.c \
    lib/ping.c \
    lib/stub.c


LIB = $(OBJDIR)/libkern.a 

all: $(addprefix $(OBJDIR)/,$(BINS))

$(OBJDIR)/test_%: tests/%.c $(LIB)
	$(CC) $(CFLAGS) $< $(LIB) -o $@

$(OBJDIR)/%.o:%.c
	$(CC) $(CFLAGS) $(KERNFLAGS) -c $< -o $@

KERNOBJS := $(addprefix $(OBJDIR)/,$(SRCS:.c=.o))

$(KERNOBJS): KERNFLAGS = -nostdinc -fno-builtin -DKERNEL -DINET -I sys

$(OBJDIR)/lib/handshake.o: CFLAGS += -Wno-parentheses

$(LIB): $(KERNOBJS) $(OBJDIR)/tools/pcap.o
	ar rcs $@ $^

$(KERNOBJS): | $(OBJDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR)/lib
	mkdir -p $(OBJDIR)/sys/kern
	mkdir -p $(OBJDIR)/sys/net
	mkdir -p $(OBJDIR)/sys/netinet