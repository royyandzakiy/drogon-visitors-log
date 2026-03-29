#include "HelloController.h"

void HelloController::sayHello(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback,
							   std::string name) {
	Json::Value data;
	data["result"] = "success";
	data["message"] = std::format("Hello, {} from the Controller!", name);
	data["time"] = trantor::Date::now().toFormattedString(false);

	auto resp = HttpResponse::newHttpJsonResponse(data);
	callback(resp);
}

void HelloController::saySecretHello(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback,
									 std::string name) {
	Json::Value data;
	data["result"] = "success";
	data["message"] = std::format("Secret Hello! {} from the Controller!", name);
	data["time"] = trantor::Date::now().toFormattedString(false);

	auto resp = HttpResponse::newHttpJsonResponse(data);
	callback(resp);
}

void HelloController::sayHelloPage(const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback,
								   std::string name) {
	HttpViewData data;
	data.insert("message", "Hello, " + name + "!");
	data.insert("time", trantor::Date::now().toFormattedString(false));
	data.insert("threadCount", std::to_string(app().getThreadNum()));

	// auto resp = HttpResponse::newHttpViewResponse("HelloView.csp", data);
	auto resp = HttpResponse::newHttpViewResponse("HelloView", data);
	callback(resp);
}