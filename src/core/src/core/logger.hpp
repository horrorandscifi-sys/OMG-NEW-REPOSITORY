#pragma once
#include <iostream>
#include <string>
class NativeLogger {
public:
    static void Log(std::string msg) { std::cout << "[NATIVE]: " << msg << std::endl; }
};
