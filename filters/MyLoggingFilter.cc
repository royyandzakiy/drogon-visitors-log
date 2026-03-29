#include "MyLoggingFilter.h"
#include <print>

MyLoggingFilter::MyLoggingFilter() {
	std::println("MyLoggingFilter constructed");
}

void MyLoggingFilter::doFilter(const drogon::HttpRequestPtr &req, drogon::FilterCallback &&fcb,
							   drogon::FilterChainCallback &&fccb) {
	std::println("MyLoggingFilter: Intercepted request to {}", req->path());

	if (req->getHeader("X-API-KEY").empty()) {
		Json::Value error;
		error["error"] = "Unauthorized";
		error["message"] = "X-API-KEY header is missing";

		auto resp = drogon::HttpResponse::newHttpJsonResponse(error);
		resp->setStatusCode(drogon::k401Unauthorized);

		return fcb(resp);
	}
	fccb();
}