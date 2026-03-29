#pragma once
#include <drogon/HttpController.h>

using namespace drogon;

class HelloController : public drogon::HttpController<HelloController> // notice CRTP style
{
  public:
	METHOD_LIST_BEGIN
	ADD_METHOD_TO(HelloController::sayHello, "hello/{name}", Get);
	METHOD_LIST_END

	void sayHello(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback, std::string name);
};