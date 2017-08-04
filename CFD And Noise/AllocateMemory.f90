SUBROUTINE AllocateMemory
    USE GlobalVariable
    IMPLICIT NONE
    
    ALLOCATE(mainRotorPerformance(numberOfMainRotorRotation * numberOfMainRotorPart, 12))
    ALLOCATE(mainRotorPerformanceAzimuth(numberOfMainRotorRotation * numberOfMainRotorPart))
    
    ALLOCATE(tailRotorPerformance(numberOfMainRotorRotation * numberOfMainRotorPart, 12))
    ALLOCATE(tailRotorPerformanceAzimuth(numberOfMainRotorRotation * numberOfMainRotorPart))
    
END SUBROUTINE