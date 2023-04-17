@echo off
set MATLAB=D:\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="D:\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=fun1_mex
set MEX_NAME=fun1_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for fun1 > fun1_mex.mki
echo CC=%COMPILER%>> fun1_mex.mki
echo CXX=%CXXCOMPILER%>> fun1_mex.mki
echo CFLAGS=%COMPFLAGS%>> fun1_mex.mki
echo CXXFLAGS=%CXXCOMPFLAGS%>> fun1_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> fun1_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> fun1_mex.mki
echo LINKER=%LINKER%>> fun1_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> fun1_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> fun1_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> fun1_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> fun1_mex.mki
echo OMPFLAGS= >> fun1_mex.mki
echo OMPLINKFLAGS= >> fun1_mex.mki
echo EMC_COMPILER=mingw64>> fun1_mex.mki
echo EMC_CONFIG=optim>> fun1_mex.mki
"D:\MATLAB\R2017b\bin\win64\gmake" -B -f fun1_mex.mk
