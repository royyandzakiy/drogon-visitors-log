#pragma once
#include <drogon/HttpController.h>

using namespace drogon;

class HelloController : public drogon::HttpController<HelloController> // notice CRTP style
{
  public:
};