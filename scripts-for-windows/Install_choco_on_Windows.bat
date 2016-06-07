echo off
rem 请注意在管理员模式下运行
rem see https://chocolatey.org/
rem 安装Chocolatey软件包管理系统
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin