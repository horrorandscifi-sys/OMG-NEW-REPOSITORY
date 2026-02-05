#pragma once
#include <chrono>
#define TIMER_START auto start = std::chrono::high_performance_clock::now();
#define TIMER_STOP(name) auto end = std::chrono::high_performance_clock::now(); \
    std::chrono::duration<double> diff = end - start; \
    printf("%s took: %f s\n", name, diff.count());
