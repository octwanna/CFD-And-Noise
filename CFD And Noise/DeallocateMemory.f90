SUBROUTINE DeallocateMemory
    USE GlobalVariable
    IMPLICIT NONE
    
    DEALLOCATE(mainRotorPerformance)
    DEALLOCATE(mainRotorPerformanceAzimuth)
    
    DEALLOCATE(tailRotorPerformance)
    DEALLOCATE(tailRotorPerformanceAzimuth)
      
END SUBROUTINE