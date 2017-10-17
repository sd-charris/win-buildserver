FROM microsoft/dotnet-framework:4.7
LABEL maintainer charris90@gmail.com
WORKDIR install.src

ADD https://download.microsoft.com/download/E/E/D/EEDF18A8-4AED-4CE0-BEBE-70A83094FC5A/BuildTools_Full.exe msbuild14.exe
RUN start /wait msbuild14.exe /q /full /log msbuild14.log

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN vs_community.exe  --includeOptional --includeRecommended -q --wait --locale en-US \
    --add Microsoft.VisualStudio.Workload.NetCoreTools \
    --add Microsoft.VisualStudio.Workload.NetWeb


RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install nuget.commandline --allow-empty-checksums -y 
RUN choco install nvm -y 
RUN choco install git -y 
RUN choco install python -y 
RUN choco install dotnetcore-sdk -y
RUN choco install maven -y


ADD template /

WORKDIR /
