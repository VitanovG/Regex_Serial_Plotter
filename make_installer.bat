@echo OFF

echo 0. WARNING
echo    ~~~~~~~
echo    windeployqt and iscc MUST be on PATH!!
echo.
echo 1. Defining variables
echo    ~~~~~~~~~~~~~~~~~~
set deps_folder=.\build\installer\deps
set exe_path=.\build\release\serial_port_plotter.exe
echo    Dependencies folder = %deps_folder%
echo    Main EXE path = %exe_path%
echo.
echo 2. Cleanig build/installer folder
del /F /Q build/installer
echo.
echo 3. Creating dependencies folder
echo    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
windeployqt --dir %deps_folder% --compiler-runtime %exe_path%
echo.
set /p compile-version=Provide .exe version (x.y.z): 
echo 4. Compiling installer
echo    ~~~~~~~~~~~~~~~~~~~
iscc /DMyAppVersion="%compile-version%" installer.iss 
echo.
echo Finished!

pause