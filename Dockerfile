FROM microsoft/windowsservercore

RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install nuget.commandline --allow-empty-checksums -y 
RUN choco install nvm -y 
RUN choco install dotnetcore-sdk -y
RUN choco install maven -y

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN C:\vs_community.exe  --includeOptional --includeRecommended -q --wait --norestart --locale en-US \
    --add Microsoft.VisualStudio.Workload.NetCoreTools \
    --add Microsoft.VisualStudio.Workload.NetWeb


