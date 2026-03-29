#pragma once
#include <drogon/HttpController.h>

using namespace drogon;

class HelloController : public HttpController<HelloController> // ? notice, uses CRTP style
{
  public:
	METHOD_LIST_BEGIN
	ADD_METHOD_TO(HelloController::sayHello, "hello/{name}", Get);
	ADD_METHOD_TO(HelloController::saySecretHello, "hello-key/{name}", Get, "MyLoggingFilter");
	METHOD_LIST_END

	void sayHello(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback, std::string name);
	void saySecretHello(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback,
						std::string name);
};