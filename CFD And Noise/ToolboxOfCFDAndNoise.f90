PROGRAM ToolboxOfCFDAndNoise
    
    USE GlobalVariable
    IMPLICIT NONE
    INTEGER(KIND=8) :: functionFlag
    
    
    CALL ReadCaseFile
    CALL AllocateMemory  
    
    WRITE(*,*) "Toolbox of CFD and Noise Usage:"
    WRITE(*,*)
    WRITE(*,*) "1. Handle Main Rotor Performance File"
    WRITE(*,*)
    WRITE(*,*) "2. Handle Tail Rotor Performance File"
    WRITE(*,*)
    WRITE(*,*) "3. Generate Observation Coord Of Radiant Sphere"
    WRITE(*,*)
    WRITE(*,*) "4. Transform To Tail Noise Observation Coord"
    WRITE(*,*)
    WRITE(*,*) "5. Generate Tecplot ASCII File According TO SPL File"
    WRITE(*,*)
    WRITE(*,*) "Input The Number And Press Enter:"
    READ(*,*) functionFlag
    
    IF (functionFlag == 1) THEN
        CALL HandleMainRotorPerformanceFile
    END IF
    
    IF (functionFlag == 2) THEN
        IF (numberOfTailBlade /= 0) THEN
            CALL HandleTailRotorPerformanceFile
        END IF
    END IF
    
    IF (functionFlag == 3) THEN
        CALL GenerateObservationCoordOfRadiantSphere
    END IF
    
    IF (functionFlag == 4) THEN
        CALL TransformToTailNoiseObservationCoord
    END IF
    
    IF (functionFlag == 5) THEN
        CALL AddTecplotASCIIHeaderToSPLFile
    END IF
     
    CALL DeallocateMemory

    PAUSE
END PROGRAM ToolboxOfCFDAndNoise