CC = gcc
CFLAGS = -g3 -ggdb -Wall -O0 -Werror=implicit-function-declaration

BINS := test_init test_pigeon test_self test_tun

OBJDIR := objs

SRCS= \
    freebsd/kern/kern_subr.c \
    freebsd/kern/uipc_domain.c \
    freebsd/kern/uipc_mbuf.c \
    freebsd/kern/uipc_socket.c \
    freebsd/kern/uipc_socket2.c \
    freebsd/kern/sys_socket.c \
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