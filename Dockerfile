FROM microsoft/dotnet-framework:4.7
LABEL maintainer charris90@gmail.com

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN vs_community.exe  --includeOptional --includeRecommended -q --wait --locale en-US \
    --add Microsoft.VisualStudio.Workload.NetWeb \
    --add Microsoft.VisualStudio.Workload.NetCoreTools 

RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install nuget.commandline --allow-empty-checksums -y 
RUN choco install nvm -y 
RUN choco install git -y 
RUN choco install python -y 
RUN choco install dotnetcore-sdk -y
RUN choco install maven -y

SHELL ["cmd.exe", "/s", "/c"]
ENTRYPOINT C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat &&
