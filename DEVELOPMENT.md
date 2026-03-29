## Backlog
- enable clang/gcc
	- try compile in linux
- integrate with sqlite
- add model
- show running data with websocket
- file uploads
- add more TESTS

## Bug List
- clang-cl always fails to compile filters/MyLogginFilter.cc
```bash
C:\project-coding\cpp\projects\drogon-visitors-log\bin\clang-win>"C:/project-coding/cpp/projects/drogon-visitors-log/bin/clang-win/drogon-visitors-log.exe"
Config loaded from: C:\project-coding\cpp\projects\drogon-visitors-log\config.json
Document root set to: C:\project-coding\cpp\projects\drogon-visitors-log\public
Server is starting... visit http://localhost:5555
20260329 18:58:29.239000 UTC 46084 ERROR middleware MyLoggingFilter not found - MiddlewaresFunction.cc:164
```