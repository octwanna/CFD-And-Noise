SUBROUTINE HandleTailRotorPerformanceFile
    USE GlobalVariable
    IMPLICIT NONE
    
    ! Local Variable
    INTEGER(KIND=8) :: errFlag, i
    CHARACTER(LEN=32) :: termName(6)
    INTEGER(KIND=8) :: TailMainREVRatio 
    INTEGER(KIND=8) :: numberOfTailRotorRotation, numberOfTailRotorPart
    REAL(KIND=8) :: tailRotorPerformanceAverage(12), actualPerformanceOfTailRotor(12)
    REAL(KIND=8) :: actualRadiumOfTailRotor, actualMainToTaildistanceX, actualAreaOfTailRotorDisk
    REAL(KIND=8) :: tailMomentAboutMainY(2)
    
    TailMainREVRatio = radiumOfMainRotor / radiumOfTailRotor
    !WRITE(*,*) TailMainREVRatio
        
    numberOfTailRotorRotation = numberOfMainRotorRotation * TailMainREVRatio
    numberOfTailRotorPart = numberOfMainRotorPart / TailMainREVRatio
    !WRITE(*,*) numberOfTailRotorRotation, numberOfTailRotorPart
    
    OPEN(UNIT = 95291, FILE = "./PERFORMANCE_T.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: PERFORMANCE_T.DAT"
    
    READ(95291,*)! Ignore 0 Degree Azimuth
    
    ! Read Data From File
    DO i = 1, numberOfMainRotorRotation * numberOfMainRotorPart
        READ(95291,*) tailRotorPerformanceAzimuth(i), & 
                      tailRotorPerformance(i,1), tailRotorPerformance(i,2), tailRotorPerformance(i,3), tailRotorPerformance(i,4),  tailRotorPerformance(i,5),  tailRotorPerformance(i,6), &
                      tailRotorPerformance(i,7), tailRotorPerformance(i,8), tailRotorPerformance(i,9), tailRotorPerformance(i,10), tailRotorPerformance(i,11), tailRotorPerformance(i,12)
    END DO
    !WRITE(*,*) tailRotorPerformance((numberOfTailRotorRotation - 1) * numberOfTailRotorPart + 1,1)
    !WRITE(*,*) "**************"
    CLOSE(95291)
    
    ! Handle Data: average data of The Last Rotation
    DO i = 1, 12
        tailRotorPerformanceAverage(i) = SUM(tailRotorPerformance((numberOfTailRotorRotation - 1) * numberOfTailRotorPart + 1:,i)) / numberOfTailRotorPart
        !WRITE(*,*) tailRotorPerformanceAverage(i)
    END DO
    
    ! Calculate Actual Force And Moment 
    
    actualChordOfMainRotor = reynoldsNumber * 1.78 / (tipMaOfMainRotor * 34.0 * 1.225)
    actualRadiumOfTailRotor = radiumOfTailRotor * actualChordOfMainRotor
    actualAreaOfTailRotorDisk = PI * actualRadiumOfTailRotor**2
    
    ! Calculate Actual Force
    DO i = 1, 3
        actualPerformanceOfTailRotor(i) = tailRotorPerformanceAverage(i) * rho * actualAreaOfTailRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2
        !actualPerformanceOfMainRotor(i) = mainRotorPerformanceAverage(i) * rho * actualAreaOfMainRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2
    END DO    
    DO i = 7, 9
        actualPerformanceOfTailRotor(i) = tailRotorPerformanceAverage(i) * rho * actualAreaOfTailRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 
    END DO
    
    ! Calculate Actual Moment 
    DO i = 4, 6
        actualPerformanceOfTailRotor(i) = tailRotorPerformanceAverage(i) * rho * actualAreaOfTailRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 * actualRadiumOfTailRotor
    END DO   
    DO i = 10, 12
        actualPerformanceOfTailRotor(i) = tailRotorPerformanceAverage(i) * rho * actualAreaOfTailRotorDisk * (340 * tipMaOfMainRotor * actualChordOfMainRotor)**2 * actualRadiumOfTailRotor    
    END DO
    
    actualMainToTaildistanceX = mainToTaildistanceX * actualChordOfMainRotor
    WRITE(*,*) "’Ê µæ‡¿ÎCFD", actualMainToTaildistanceX
    tailMomentAboutMainY(1) =  actualPerformanceOfTailRotor(3) * actualMainToTaildistanceX
    tailMomentAboutMainY(2) =  actualPerformanceOfTailRotor(9) * actualMainToTaildistanceX
    
    
    ! Write Data To File
    DATA termName /"Force  X: ", "Force  Y: ", "Force  Z: ", "Moment X: ", "Moment Y: ", "Moment Z: "/
    OPEN(UNIT = 95290, FILE = "./[OUT]AveragePerformanceOfTailRotor.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: [OUT]AveragePerformanceOfTailRotor.DAT"
    
    WRITE(95290,*) "Average Performance Of Tail Rotor"
    WRITE(95290,*)
    
    WRITE(95290,*) "Inviscous:       Coefficient             Actual"
    DO i = 1, 6!  Inviscous
        WRITE(95290,*) TRIM(termName(i)), tailRotorPerformanceAverage(i), actualPerformanceOfTailRotor(i)
    END DO
    WRITE(95290,*) "Actual Tail Moment About Main Y: ", tailMomentAboutMainY(1)

    WRITE(95290,*)
    
    WRITE(95290,*) "Viscous:         Coefficient             Actual"
    DO i = 7, 12! Viscous
         WRITE(95290,*) TRIM(termName(i-6)), tailRotorPerformanceAverage(i), actualPerformanceOfTailRotor(i)
    END DO
    WRITE(95290,*) "Actual Tail Moment About Main Y: ", tailMomentAboutMainY(2)
     
    CLOSE(95290)
    
    
    
END SUBROUTINE