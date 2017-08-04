MODULE GlobalVariable
    IMPLICIT NONE
    
    REAL(KIND=8) :: mu, reynoldsNumber, CFL
    INTEGER(KIND=8) :: numberOfMainRotorRotation,numberOfInternalIteration, numberOfMainRotorPart
    INTEGER(KIND=8) :: numberOfMainRotor, numberOfMainBlade, numberOfTailBlade
    
    REAL(KIND=8) :: radiumOfMainRotor, alphaTPPOfMainRotor, tipMaOfMainRotor
    REAL(KIND=8) :: radiumOfTailRotor, alphaTPPOfTailRotor, tipMaOfTailRotor
    
    REAL(KIND=8) :: mainToTaildistanceX
     
    REAL(KIND=8), ALLOCATABLE :: mainRotorPerformance(:,:), mainRotorPerformanceAzimuth(:)
    REAL(KIND=8), ALLOCATABLE :: tailRotorPerformance(:,:), tailRotorPerformanceAzimuth(:)
    
    !Actual Value
    REAL(KIND=8) :: actualChordOfMainRotor
    REAL(KIND=8), PARAMETER :: PI = 3.1415926535898
    REAL(KIND=8), PARAMETER :: rho = 1.225
    
    REAL(KIND=8) :: DTR = PI / 180.0
    
    END MODULE
    
!已使用的文件索引：  
!   95271   95281   95291           95311
!           95280   95290   95300   95310