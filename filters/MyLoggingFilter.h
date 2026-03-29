#pragma once
#include <drogon/HttpFilter.h>

class MyLoggingFilter : public drogon::HttpFilter<MyLoggingFilter> {
  public:
	MyLoggingFilter(); // ! defining ctor is required in clang, to not get optimized and discarded as unused object.
					   // ! else will cause MyLoggingFilter not found - MiddlewaresFunction.cc:164

	void doFilter(const drogon::HttpRequestPtr &req, drogon::FilterCallback &&fcb,
				  drogon::FilterChainCallback &&fccb) override;
};