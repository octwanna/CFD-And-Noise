SUBROUTINE ReadCaseFile
    USE GlobalVariable
    IMPLICIT NONE
    
    ! Local Variable
    INTEGER(KIND=8) :: errFlag, i  
    
    OPEN(UNIT = 95271, FILE = "./CASE.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: CASE.DAT"
      
    
    READ(95271,*)
    READ(95271,*)
    
    READ(95271,*)
    READ(95271,*) mu, reynoldsNumber, CFL
    !WRITE(*,*)    mu, reynoldsNumber, CFL
    
    READ(95271,*)
    READ(95271,*) numberOfMainRotorRotation, numberOfInternalIteration, numberOfMainRotorPart
    !WRITE(*,*)    numberOfMainRotorRotation, numberOfInternalIteration, numberOfMainRotorPart

    READ(95271,*)
    READ(95271,*) numberOfMainRotor, numberOfMainBlade, numberOfTailBlade
    !WRITE(*,*)    numberOfMainRotor, numberOfMainBlade, numberOfTailBlade
    ! Ignore Line 9 ~ Line 13
    DO i = 9, 13
        READ(95271,*)
    END DO
    
    READ(95271,*) radiumOfMainRotor, alphaTPPOfMainRotor, tipMaOfMainRotor
    !WRITE(*,*)    radiumOfMainRotor, alphaTPPOfMainRotor, tipMaOfMainRotor
    
    ! Ignore Line 15 ~ Line 25
    DO i = 15, 25
        READ(95271,*)
    END DO
    
    ! Ignore Main Rotor Grid Info According To The Number Of Blade Of Main Rotor 
    DO i = 1, numberOfMainBlade
        READ(95271,*)
    END DO
    
    ! Ignore Info
    DO i = 26 + numberOfMainBlade, 26 + numberOfMainBlade + 4
        READ(95271,*)
    END DO
    
    READ(95271,*) radiumOfTailRotor, alphaTPPOfTailRotor, tipMaOfTailRotor
    !WRITE(*,*)    radiumOfTailRotor, alphaTPPOfTailRotor, tipMaOfTailRotor
    
    READ(95271,*)
    READ(95271,*) MainToTaildistanceX
    !WRITE(*,*) "++++++++++++++++++++++++++++++++++++++++"
    !WRITE(*,*)    MainToTaildistanceX
    
    CLOSE(95271)
    !WRITE(*,*) "Please Input Actual Chord Length (Unit:m): "
    !READ(*,*) actualChordOfMainRotor
    
END SUBROUTINE
    
