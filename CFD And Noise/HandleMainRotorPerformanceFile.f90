SUBROUTINE HandleMainRotorPerformanceFile
    USE GlobalVariable
    IMPLICIT NONE
    
    ! Local Variable
    INTEGER(KIND=8) :: errFlag, i
    CHARACTER(LEN=32) :: termName(6)
    REAL(KIND=8) :: mainRotorPerformanceAverage(12), actualPerformanceOfMainRotor(12)
    REAL(KIND=8) :: actualRadiumOfMainRotor, actualAreaOfMainRotorDisk
    
    OPEN(UNIT = 95281, FILE = "./PERFORMANCE_M.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: PERFORMANCE_M.DAT"
    
    READ(95281,*)! Ignore 0 Degree Azimuth
    
    ! Read Data From File
    DO i = 1, numberOfMainRotorRotation * numberOfMainRotorPart
        READ(95281,*) mainRotorPerformanceAzimuth(i), & 
                      mainRotorPerformance(i,1), mainRotorPerformance(i,2), mainRotorPerformance(i,3), mainRotorPerformance(i,4),  mainRotorPerformance(i,5),  mainRotorPerformance(i,6), &
                      mainRotorPerformance(i,7), mainRotorPerformance(i,8), mainRotorPerformance(i,9), mainRotorPerformance(i,10), mainRotorPerformance(i,11), mainRotorPerformance(i,12)
    END DO
    !WRITE(*,*) mainRotorPerformance((numberOfRotation - 1) * numberOfPart + 1,1)
    !WRITE(*,*) "**************"
         
    ! Handle Data: average data of The Last Rotation
    DO i = 1, 12
        mainRotorPerformanceAverage(i) = SUM(mainRotorPerformance((numberOfMainRotorRotation - 1) * numberOfMainRotorPart + 1:,i)) / numberOfMainRotorPart
        !WRITE(*,*) mainRotorPerformanceAverage(i)
    END DO
    
    CLOSE(95281)
    
    actualChordOfMainRotor = reynoldsNumber * 1.78 / (tipMaOfMainRotor * 34.0 * 1.225)
    !WRITE(*,*) "’Ê µœ“≥§£∫", actualChordOfMainRotor
    actualRadiumOfMainRotor = radiumOfMainRotor * actualChordOfMainRotor
    actualAreaOfMainRotorDisk = PI * actualRadiumOfMainRotor**2
    
    ! Calculate Actual Force
    DO i = 1, 3
        actualPerformanceOfMainRotor(i) = mainRotorPerformanceAverage(i) * rho * actualAreaOfMainRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2
    END DO    
    DO i = 7, 9
        actualPerformanceOfMainRotor(i) = mainRotorPerformanceAverage(i) * rho * actualAreaOfMainRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 
    END DO
    
    ! Calculate Actual Moment 
    DO i = 4, 6
        actualPerformanceOfMainRotor(i) = mainRotorPerformanceAverage(i) * rho * actualAreaOfMainRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 * actualRadiumOfMainRotor
    END DO   
    DO i = 10, 12
        actualPerformanceOfMainRotor(i) = mainRotorPerformanceAverage(i) * rho * actualAreaOfMainRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 * actualRadiumOfMainRotor    
    END DO
    
    
    ! Write Data To File
    DATA termName /"Force  X: ", "Force  Y: ", "Force  Z: ", "Moment X: ", "Moment Y: ", "Moment Z: "/
    OPEN(UNIT = 95280, FILE = "./[OUT]AveragePerformanceOfMainRotor.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: [OUT]AveragePerformanceOfMainRotor.DAT"
    
    WRITE(95280,*) "Average Performance Of Main Rotor"
    WRITE(95280,*)
    
    WRITE(95280,*) "Inviscous:       Coefficient             Actual"
    DO i = 1, 6!  Inviscous
        WRITE(95280,*) TRIM(termName(i)), mainRotorPerformanceAverage(i), actualPerformanceOfMainRotor(i)
    END DO
    
    WRITE(95280,*)
    
    WRITE(95280,*) "Viscous:         Coefficient             Actual"
    DO i = 7, 12! Viscous
         WRITE(95280,*) TRIM(termName(i-6)), mainRotorPerformanceAverage(i), actualPerformanceOfMainRotor(i)
    END DO
     
    CLOSE(95280)
   
END SUBROUTINE