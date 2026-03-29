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