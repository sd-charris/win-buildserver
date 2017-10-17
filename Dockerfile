FROM microsoft/windowsservercore

ADD https://aka.ms/vs/15/release/vs_community.exe vs_community.exe
RUN vs_community.exe --wait --includeRecommended \
    --add Microsoft.VisualStudio.Workload.MSBuildTools \
    --add Microsoft.VisualStudio.Workload.NetCoreTools \
    --add Microsoft.VisualStudio.Workload.NetWeb \
    --add Microsoft.VisualStudio.Workload.Node \
    --add Microsoft.Net.ComponentGroup.DevelopmentPrerequisites \
    --add Microsoft.Net.ComponentGroup.TargetingPacks.Common \
    --add Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools \
    --add Microsoft.Net.ComponentGroup.4.7.DeveloperTools

RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN choco install dotnetcore-sdk -y
RUN choco install nvm -y 
RUN choco install maven -y
RUN choco install git -y
RUN choco install python -y
