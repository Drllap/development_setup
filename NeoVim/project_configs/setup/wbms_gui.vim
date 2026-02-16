!conan1 install ./build_dependencies/conanfile.py -pr d64 --build missing
!conan1 build ./build_dependencies/conanfile.py
!conan1 install ./build_dependencies/conanfile.py -pr ninja --install-folder build_ninja --output-folder build_ninja
let conan_toolchain = "./build_ninja/build/Debug/generators/conan_toolchain.cmake"->fnamemodify(':p')->substitute('\','/','g')
execute "!cmake  -B ./build_ninja -S ./src/ -G Ninja
      \ -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
      \ -DBUILD_TESTING=ON
      \ -DCMAKE_POLICY_DEFAULT_CMP0091=NEW
      \ -DCMAKE_TOOLCHAIN_FILE=" .. conan_toolchain

!New-Item -ItemType SymbolicLink -Name .\src\compile_commands.json -Value ..\build_ninja\compile_commands.json -Force
