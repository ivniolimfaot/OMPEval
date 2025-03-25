@echo on
mkdir build
cd build
cmake -G "MinGW Makefiles" ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DCMAKE_CXX_COMPILER=g++ ^
      -DCMAKE_C_COMPILER=gcc ..
cmake --build .
cmake --install .
