/* rack.c set rack type */

#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
#include <string.h>

#include "../include/params.h"
#include "../include/fs_types.h"
#include "../include/fscom.h"

extern struct fscom *shm_addr;

main(argc, argv)
int argc;
char **argv;
{
    void setup_ids();
    int i;

    setup_ids();

    if ( 1 != nsem_take("fs   ",1)) {
         exit( -1);
    }

    if(argc >= 1) {
      if(0==strcmp(argv[1],"mk4")) {
	shm_addr->equip.rack = MK4;
	shm_addr->equip.rack_type = MK4;
      } else if(0==strcmp(argv[1],"rdbe")) {
	shm_addr->equip.rack = RDBE;
	shm_addr->equip.rack_type = RDBE;
      } else {
	fprintf(stderr,"Unsupported rack type: '%s'\n",argv[1]);
	exit(-1);
      }
    } else {
	fprintf(stderr,"No rack type specified\n");
	exit(-1);
    }

    exit( 0);
}
