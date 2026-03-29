#include "MyLoggingFilter.h"

void MyLoggingFilter::doFilter(const HttpRequestPtr &req, FilterCallback &&fcb, FilterChainCallback &&fccb) {
	std::println("MyLoggingFilter: Intercepted request to {}", req->path());

	if (req->getHeader("X-API-KEY").empty()) {
		Json::Value error;
		error["error"] = "Unauthorized";
		error["message"] = "X-API-KEY header is missing";

		auto resp = HttpResponse::newHttpJsonResponse(error);
		resp->setStatusCode(k401Unauthorized);

		return fcb(resp);
	}
	fccb();
}