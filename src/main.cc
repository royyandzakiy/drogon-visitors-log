#include <drogon/drogon.h>
#include <filesystem>
#include <print>

using namespace drogon;

auto main(int argc, char **argv) -> int {
	// ? example of manually adding route
	app().registerHandler("/test",
						  [](const HttpRequestPtr &req, std::function<void(const HttpResponsePtr &)> &&callback) {
							  Json::Value data;
							  data["result"] = "success";
							  data["message"] = "Test, who ever you are!";
							  data["time"] = trantor::Date::now().toFormattedString(false);

							  auto resp = HttpResponse::newHttpJsonResponse(data);
							  callback(resp);
						  },
						  {Get});

	try {
		// dynamically set config.json & index.html
		std::filesystem::path exePath =
			std::filesystem::path(app().getCustomConfig()["binary_path"].asString()).parent_path();
		std::filesystem::path configPath = std::filesystem::current_path() / "config.json";

		auto rootPath = std::filesystem::canonical(std::filesystem::path(argv[0]).parent_path() / "../../..");
		auto absoluteConfig = rootPath / "config.json";

		app().loadConfigFile(absoluteConfig.string());
		app().setDocumentRoot((rootPath / "public").string());

		std::println("Config loaded from: {}", absoluteConfig.string());
		std::println("Document root set to: {}", app().getDocumentRoot());
	} catch (const std::exception &e) {
		std::println("Failed to load config: {}", e.what());
		return 1;
	}

	std::println("Server is starting... visit http://localhost:5555"); // port 5555 is set via config.json
	app().run();

	return 0;
}