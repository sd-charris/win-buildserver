#FROM microsoft/windowsservercore:10.0.14393.1715
FROM microsoft/windowsservercore:10.0.14393.1770
LABEL maintainer charris90@gmail.com

SHELL ["powershell.exe", "-ExecutionPolicy", "Bypass", "-Command"]

RUN $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    $VerbosePreference = 'Continue'; \
    Invoke-WebRequest -Uri https://aka.ms/vscollect.exe -OutFile C:\collect.exe

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN $ErrorActionPreference = 'Stop'; \
    $VerbosePreference = 'Continue'; \
    $p = Start-Process -Wait -PassThru -FilePath C:\vs_community.exe  -ArgumentList '--includeOptional --includeRecommended -q --wait --locale en-US --add Microsoft.VisualStudio.Workload.NetCoreTools --add Microsoft.VisualStudio.Workload.NetWeb'; \
    if ($ret = $p.ExitCode) { c:\collect.exe; throw ('Install failed with exit code 0x{0:x}' -f $ret) }


RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install nuget.commandline --allow-empty-checksums -y 
RUN choco install nvm -y 
RUN choco install git -y 
RUN choco install python -y 
RUN choco install dotnetcore-sdk -y
RUN choco install maven -y

ADD template /

