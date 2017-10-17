FROM microsoft/windowsservercore

WORKDIR install.src

RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install nuget.commandline --allow-empty-checksums -y 
RUN choco install nvm -y 
RUN choco install dotnetcore-sdk -y
RUN choco install maven -y
RUN choco install git -y
run choco install python -y

ADD https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe msbuild14.exe
RUN start /wait msbuild14.exe /q /full /log msbuild14.log

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN vs_community.exe -q --wait --includeRecommended \
    --add Microsoft.VisualStudio.Workload.MSBuildTools \
    --add Microsoft.VisualStudio.Workload.NetCoreTools \
    --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites \
    --add Microsoft.Net.ComponentGroup.TargetingPacks.Common \
    --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools \
    --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools 
