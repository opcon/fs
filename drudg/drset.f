      SUBROUTINE DRSET(LINSTQ)
C
C   DRSET reads certain parameter values from the $PARAM section
C
      include '../skdrincl/skparm.ftni'
      include 'drcom.ftni'
      include '../skdrincl/statn.ftni'
      include '../skdrincl/skobs.ftni'
C
C     INPUT VARIABLES:
      integer*2 LINSTQ(*)
C      - input string, length=word 1
C
C   LOCAL VARIABLES
      integer i2long,ichmv,ias2b,igtky !functions
      integer is,ich,ic1,ic2,nc,idummy,ikey,inum
      integer*2 LKEYWD(12),lkey
C               - Key word, longest is 22 characters
      character*2 ckey
C
C  History
C 970401 nrv New. Copied from sked's PRSET, leaving only those
C                 parameters drudg is interested in.
C
C
C  1. Now parse the input string, getting each key word and its value.
C
      ICH = 1
100   CALL IFILL(LKEYWD,1,24,oblank)
      CALL GTFLD(LINSTQ(2),ICH,i2long(LINSTQ(1)),IC1,IC2)
      IF  (IC1.EQ.0) THEN
        RETURN
      END IF
      NC = IC2-IC1+1
      IDUMMY = ICHMV(LKEYWD,3,LINSTQ(2),IC1,NC)
      LKEYWD(1) = NC
      ikey = IGTKY(LKEYWD,2,LKEY)
      call hol2char(lkey,1,2,ckey)
C
      IF  (ckey.eq.'SP'.OR.ckey.eq.'PA'.OR.ckey.eq.'SO'.OR.
     .     ckey.eq.'HD'.OR.ckey.eq.'TP'.OR.ckey.eq.'TE') then
        CALL GTFLD(LINSTQ(2),ICH,i2long(LINSTQ(1)),IC1,IC2)
        if (ic1.eq.0) then
          write(luscn,'("DRSET03 - Missing parameter value.")')
          return
        endif
        INUM = IAS2B(LINSTQ(2),IC1,IC2-IC1+1)
        IF  (INUM.lt.0) THEN
          write(luscn,'("DRSET04 - Invalid parameter value.")')
          RETURN
        END IF
        IF (ckey.eq.'SP') THEN
          ISETTM = INUM
        ELSE IF (ckey.eq.'PA') THEN
          IPARTM = INUM
        ELSE IF (ckey.eq.'SO') THEN
          ISORTM = INUM
        ELSE IF (ckey.eq.'HD') THEN
          IHDTM = INUM
        ELSE IF (ckey.eq.'TP') THEN
          ITAPTM = INUM
        else if (ckey.eq.'TE') then
          do is=1,nstatn
            itearl(is) = inum
          enddo
        endif
      endif
 
C  5.  Test to see if there is more to the line which we need to
C      decode.  If so, go back to parse some more.
 
900   IF ((LINSTQ(1)-ICH).GT.0) GOTO 100
C
      RETURN
      END