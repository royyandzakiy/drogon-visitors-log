#pragma once
#include <deque>
#include <drogon/HttpController.h>
#include <mutex>
#include <string>

class HelloController : public drogon::HttpController<HelloController> // ? notice, uses CRTP style
{
  private:
	std::deque<std::pair<std::string, std::string>> m_visitors;
	std::mutex m_visitorMutex;

  public:
	METHOD_LIST_BEGIN
	ADD_METHOD_TO(HelloController::sayHello, "/hello/{name}", drogon::Get);
	ADD_METHOD_TO(HelloController::saySecretHello, "/hello-key/{name}", drogon::Get, "MyLoggingFilter");
	ADD_METHOD_TO(HelloController::renderHelloPage, "/hello-page/{name}", drogon::Get);
	ADD_METHOD_TO(HelloController::renderHelloVisitors, "/visitors", drogon::Get);
	METHOD_LIST_END

	void sayHello(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback,
				  std::string name);
	void saySecretHello(const drogon::HttpRequestPtr &req,
						std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string name);
	void renderHelloPage(const drogon::HttpRequestPtr &req,
						 std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string name);
	void renderHelloVisitors(const drogon::HttpRequestPtr &req,
							 std::function<void(const drogon::HttpResponsePtr &)> &&callback);
};