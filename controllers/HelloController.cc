#include "HelloController.h"
#include <print>

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

void HelloController::renderHelloPage(const HttpRequestPtr &req,
									  std::function<void(const HttpResponsePtr &)> &&callback, std::string name) {
	// adding to visitors log
	std::scoped_lock lock(m_visitorMutex);
	m_visitors.push_front({name, trantor::Date::now().toFormattedString(false)});
	if (m_visitors.size() > 10)
		m_visitors.pop_back();

	HttpViewData data;
	data.insert("message", "Hello, " + name + "!");
	data.insert("time", trantor::Date::now().toFormattedString(false));
	data.insert("threadCount", std::to_string(app().getThreadNum()));

	auto resp = HttpResponse::newHttpViewResponse("HelloView.csp", data);
	callback(resp);
}

void HelloController::renderHelloVisitors(const HttpRequestPtr &req,
										  std::function<void(const HttpResponsePtr &)> &&callback) {
	HttpViewData data;

	std::println("renderHelloVisitors called!");

	std::scoped_lock lock(m_visitorMutex);
	data.insert("visitors", m_visitors);

	auto resp = HttpResponse::newHttpViewResponse("VisitorsLog.csp", data);
	callback(resp);
}