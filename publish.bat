@echo off
REM Builds a self-contained single-file Windows release (no .NET install needed on the client PC).
REM Requires the .NET 8 SDK on this (developer) PC.
dotnet publish PetroleumPump.Desktop\PetroleumPump.Desktop.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -o publish
echo.
echo Done. Copy everything inside the "publish" folder to the client PC and run PetroPumpManager.exe
pause
