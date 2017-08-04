SUBROUTINE TransformToTailNoiseObservationCoord
    !计算尾桨噪声时，将尾桨当成旋翼来计算，需要转换一下真实观察点的坐标
    !为了完成论文中的内容，尾桨和旋翼只CFD坐标系的X方向有偏置，在Y和Z方向无偏置
    !噪声前处理的部分内容需要依赖与CFD，所以将这个工程合并到CFDPost，新名称为Toolbox of CFD and Noise
    USE GlobalVariable
    IMPLICIT NONE
    
    REAL(KIND=8) :: actualMainToTaildistanceX  
    INTEGER(KIND=8) :: errFlag
    
    actualChordOfMainRotor = reynoldsNumber * 1.78 / (tipMaOfMainRotor * 34.0 * 1.225)
    actualMainToTaildistanceX = mainToTaildistanceX * actualChordOfMainRotor
    WRITE(*,*) "真实距离Noise", actualMainToTaildistanceX
    
    !将尾桨当成旋翼来计算，首先将旋翼向后平移。
    
    !绕噪声坐标系的-Y轴旋转90°
    
    
END SUBROUTINE TransformToTailNoiseObservationCoord