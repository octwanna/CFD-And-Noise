SUBROUTINE AddTecplotASCIIHeaderToSPLFile
    !噪声计算后会生成SPL_FWH.DAT文件，每一行会按照下面的格式存储：
    !观察点X坐标     观察点Y坐标      观察点Z坐标      厚度噪声声压级        载荷噪声声压级        总噪声声压级
    !输入：输入观察点个数，即SPL_FWH.DAT的行数
    !输出：在SPL_FWH.DAT文件的开头插入一个Tecplot的Header，输出为FWHSPLTecplot.DAT，使其能直接被Tecplot打开
    IMPLICIT NONE
    
    !REAL(KIND=8) :: actualMainToTaildistanceX  
    REAL(KIND=8), ALLOCATABLE :: FWHSPLFile(:,:)
    INTEGER(KIND=8) :: errFlag
    INTEGER(KIND=8) :: i
    INTEGER(KIND=8) :: numberOfObservationPoints
    
    !Read File
    OPEN(UNIT = 95311, FILE = "./SPL_FWH.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: SPL_FWH.DAT"
    
    WRITE(*,*) "Please Input The Number Of Observation Points(Default - 370):"
    READ(*,*) numberOfObservationPoints
    IF(numberOfObservationPoints /= 370) WRITE(*,*) "Please Modify The Source Code!"
    
    ALLOCATE(FWHSPLFile(numberOfObservationPoints,6))
    
    DO i = 1, numberOfObservationPoints
        READ(95311,*) FWHSPLFile(i,1), FWHSPLFile(i,2), FWHSPLFile(i,3), FWHSPLFile(i,4), FWHSPLFile(i,5), FWHSPLFile(i,6)
    END DO
    !WRITE(*,*) FWHSPLFile(1,1), FWHSPLFile(1,2), FWHSPLFile(1,3), FWHSPLFile(1,4), FWHSPLFile(1,5), FWHSPLFile(1,6)
    !WRITE(*,*) FWHSPLFile(numberOfObservationPoints,1), FWHSPLFile(numberOfObservationPoints,2), FWHSPLFile(numberOfObservationPoints,3), FWHSPLFile(numberOfObservationPoints,4), FWHSPLFile(numberOfObservationPoints,5), FWHSPLFile(numberOfObservationPoints,6)
    
    CLOSE(95311)
    
    !Write File
    OPEN(UNIT = 95310, FILE = "./FWHSPLTecplot.DAT", IOSTAT = errFlag)
    IF(errFlag /= 0) WRITE(*,*) "Can not open file: FWHSPLTecplot.DAT"
    WRITE(95310,*) 'VARIABLES = "X", "Y", "Z", "Thickness Noise", "Load Noise", "Total Noise"'
    WRITE(95310,*) 'ZONE  I= 37, J= 10, K= 1, DATAPACKING=POINT, VARLOCATION=([4,5,6]=NODAL)'
    DO i = 1, numberOfObservationPoints
        WRITE(95310,"(6F15.8)") FWHSPLFile(i,1), FWHSPLFile(i,2), FWHSPLFile(i,3), FWHSPLFile(i,4), FWHSPLFile(i,5), FWHSPLFile(i,6)!设置格式化输出可以保证一个WRITE的数据占一行
    END DO
    CLOSE(95310)
    
    DEALLOCATE(FWHSPLFile)
    
    
END SUBROUTINE AddTecplotASCIIHeaderToSPLFile