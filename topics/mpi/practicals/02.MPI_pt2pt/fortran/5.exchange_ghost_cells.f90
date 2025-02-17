PROGRAM ghost_cell_exchange

! process decomposition on 4*4 grid
!  |-----------|
!  | 0| 4| 8|12|
!  |-----------|
!  | 1| 5| 9|13|
!  |-----------|
!  | 2| 6|10|14|
!  |-----------|
!  | 3| 7|11|15|
!  |-----------|

! Each process works on a 10*10 (SUBDOMAIN) block of data
! the d corresponds to data, g corresponds to "ghost cells"
! and x are empty (not exchanged for now)

!  xggggggggggx
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  gddddddddddg
!  xggggggggggx

! task: each rank has to find its left and right neighbor and
! send them the data they need (left array goes to left neighbor
!                               and right array goes to right neighbor)

  USE MPI
  IMPLICIT NONE

  INTEGER SUBDOMAIN, DOMAINSIZE
  PARAMETER (SUBDOMAIN = 10)
  PARAMETER (DOMAINSIZE = SUBDOMAIN+2)
  INTEGER rank, size, i, j, rank_right, rank_left, ierror
  DOUBLE PRECISION data(DOMAINSIZE,DOMAINSIZE)
  INTEGER request
  INTEGER status(MPI_STATUS_SIZE)

  CALL MPI_Init(ierror)
  CALL MPI_Comm_rank(MPI_COMM_WORLD, rank, ierror)
  CALL MPI_Comm_size(MPI_COMM_WORLD, size, ierror)

  IF (size.NE.16) THEN
     WRITE (*,*)"please run this with 16 processors"
     CALL MPI_Finalize(ierror);
     STOP
  END IF
  DO i=1, DOMAINSIZE, 1
    DO j=1, DOMAINSIZE, 1
      data(i,j)=rank
    END DO
  END DO

  rank_right = 0 !find the rank of my right neighbour
  rank_left = 0 !find the rank of my left neighbour

  !  ghost cell exchange with the neighbouring cells on the left and on the right using:
  !  a) MPI_Send, MPI_Irecv
  !  b) MPI_Isend, MPI_Recv
  !  c) MPI_Sendrecv

  !  to the left
  ! a)

  ! b)

  ! c)

  !  to the right
  ! a)

  ! b)

  ! c)

  IF (rank.EQ.9) THEN
     WRITE (*,*) 'data of rank 9 after communication'
     DO i=1, DOMAINSIZE, 1
        DO j=1, DOMAINSIZE, 1
          WRITE (*,'(F6.1)',advance='no') data(i,j)
        END DO
        WRITE (*,*)
     END DO
  END IF

  CALL MPI_Finalize(ierror);

END PROGRAM
