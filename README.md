# Drogon Visitors Log App

A modern C++23 web application built with the Drogon framework.

## Quick Start

Try these API endpoints:
- `GET /hello/{name}` - Returns a personalized greeting
- `GET /hello-page/{name}` - Renders an HTML page with your name
- `GET /visitors` - View all recorded visitors
- `GET /hello-key/{name}` - Protected endpoint requiring API key (demonstrates filter usage)

## Features

### Core Application
- C++23 standard with modern language features
- HTTP controllers with CRTP pattern
- Custom filters for request processing
- Dynamic view rendering with C++ templates
- Thread-safe visitor tracking with mutex protection
- JSON configuration (port, settings)

### Build System & Tooling
- CMake 3.20+ with preset configurations:
  - Windows: MSVC, Clang-cl
  - Linux: Clang, GCC
- Custom CMake scripts:
  - `config_vcpkg.cmake` - Validates vcpkg installation and packages
  - `config_drogon.cmake` - Verifies Drogon toolchain and dependencies
  - `local_path.cmake` - Machine-specific vcpkg path configuration
- Centralized `bin/` directory for all build outputs
- FetchContent integration for fmt library (no vcpkg required for fmt)

### Development Experience
- Visual Studio Code configuration:
  - `settings.json` - Proper include paths for IntelliSense
  - `launch.json` - Debug configurations for all build presets
- File naming convention: `.cc` and `.h` files (Drogon standard)
- OS-agnostic project setup ready for cross-platform development

## Screenshots

![API Response Example](docs/image.png)
*Example of API response from `/hello/username`*

![Visitor Log View](docs/image-1.png)
*Visitor tracking page showing all recorded visits*

## Project Structure

```
.
├── bin/                    # Centralized build outputs
├── cmake/                  # Custom CMake scripts
│   ├── local_path.cmake    # User-specific vcpkg path
│   ├── config_vcpkg.cmake  # vcpkg validation
│   └── config_drogon.cmake # Drogon validation
├── controllers/            # HTTP controllers (.h, .cc)
├── filters/                # Request filters
├── views/                  # Dynamic view templates
├── public/                 # Static files (index.html)
├── src/                    # Application entry point
└── test/                   # Unit tests
```

## Build Instructions

1. Configure vcpkg path in `cmake/local_path.cmake`
2. Install dependencies via vcpkg:
   ```bash
   ./vcpkg install drogon --triplet x64-linux  # or x64-windows
   ```
3. Configure with CMake presets:
   ```bash
   cmake --preset gcc-linux-debug
   cmake --build --preset gcc-linux-debug
   ```
4. Run the server:
   ```bash
   ./bin/gcc-linux-debug/drogon-visitors-log
   ```

## Note

This project setup was designed to be OS-agnostic and can serve as a template for future C++ projects. The CMake configuration provides robust validation for vcpkg and Drogon dependencies across different platforms and compilers.