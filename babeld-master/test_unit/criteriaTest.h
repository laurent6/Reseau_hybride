#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
/* nothing */
#elif defined(__GNUC__)
#define inline __inline
#if  (__GNUC__ >= 3)
#define restrict __restrict
#else
#define restrict /**/
#endif
#else
#define inline /**/
#define restrict /**/
#endif

#if defined(__GNUC__) && (__GNUC__ >= 3)
#define ATTRIBUTE(x) __attribute__ (x)
#define LIKELY(_x) __builtin_expect(!!(_x), 1)
#define UNLIKELY(_x) __builtin_expect(!!(_x), 0)
#else
#define ATTRIBUTE(x) /**/
#define LIKELY(_x) !!(_x)
#define UNLIKELY(_x) !!(_x)
#endif

#if defined(__GNUC__) && (__GNUC__ >= 4) && (__GNUC_MINOR__ >= 3)
#define COLD __attribute__ ((cold))
#else
#define COLD /**/
#endif

#ifndef IF_NAMESIZE
#include <sys/socket.h>
#include <net/if.h>
#endif

#ifdef HAVE_VALGRIND
#include <valgrind/memcheck.h>
#else
#ifndef VALGRIND_MAKE_MEM_UNDEFINED
#define VALGRIND_MAKE_MEM_UNDEFINED(a, b) do {} while(0)
#endif
#ifndef VALGRIND_CHECK_MEM_IS_DEFINED
#define VALGRIND_CHECK_MEM_IS_DEFINED(a, b) do {} while(0)
#endif
#endif


struct timeval now;

unsigned char myid[8];
int have_id = 0;
int debug = 0;
extern int use_battery;
int link_detect = 0;
int all_wireless = 0;
int has_ipv6_subtrees = 0;
int default_wireless_hello_interval = -1;
int default_wired_hello_interval = -1;
int resend_delay = -1;
int random_id = 0;
int do_daemonise = 0;
int skip_kernel_setup = 0;
const char *logfile = NULL,
    *pidfile = "/var/run/babeld.pid",
    *state_file = "/var/lib/babel-state";

unsigned char *receive_buffer = NULL;
int receive_buffer_size = 0;

const unsigned char zeroes[16] = {0};
const unsigned char ones[16] =
    {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
     0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

int protocol_port;
unsigned char protocol_group[16];
int protocol_socket = -1;
int kernel_socket = -1;


struct timeval check_neighbours_timeout, check_interfaces_timeout;
static volatile sig_atomic_t exiting = 0, dumping = 0, reopening = 0;


void schedule_neighbours_check(int msecs, int override);
void schedule_interfaces_check(int msecs, int override);
int resize_receive_buffer(int size);


