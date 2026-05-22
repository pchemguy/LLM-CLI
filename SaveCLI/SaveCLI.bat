@echo off

"%windir%\Microsoft.NET\Framework64\v4.0.30319\csc.exe" /target:exe /out:%~n0.exe %~n0.cs
