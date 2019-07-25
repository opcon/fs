	SUBROUTINE getqual(cql,ix,squal)
C
C  getqual gets either qual 1 or qual 2 bbsynth depending
C  on cql.
C
C   COMMON BLOCKS USED
	include 'skparm.ftni'
	include 'drcom.ftni'
	include 'sourc.ftni'
	include 'statn.ftni'
	include 'freqs.ftni'
C
C   HISTORY:
C  WHO   WHEN   WHAT
C  gag   900806 CREATED
C  gag   910513 Added parameter to nchanv to handle multiple vlba stations.
C
C
C  INPUT:
	character cql   ! what qual (set) number we want
	integer ix    ! the video converter
C
C  OUTPUT:
	real*4 squal(14)
C
C
C   SUBROUTINES
C     CALLED BY: vlbah
C     CALLED:
C
C
C  LOCAL VARIABLES
	integer iy    ! counter
	character*3 cs  ! the set number
C
C  INITIALIZED
C
C
C  This loop will compare the set number and BBC number
C  to get the correct bbsynth for the appropriate qual for the
C  video converter ix.

	iy = 1
	do while (iy.le.nchanv(nvset))
	  cs = csetv(nvset,iy)
	  if ((iy.ne.ix).and.((cs(1:1).eq.cql).or.(cs.eq.'1,2')).and.
     .      (ibbcv(nvset,ix).eq.ibbcv(nvset,iy))) then
		  squal(ix)=synthv(iy)
	  iy = nchanv(nvset)
	  end if
	  iy = iy + 1
	end do

C
	RETURN
	END
