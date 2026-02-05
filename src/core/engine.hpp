#pragma once
#include <vector>
#include <thread>
#include <cmath>

class ComputeEngine {
public:
    static void ParallelProcess(double* data, size_t size) {
        auto worker = [&](size_t start, size_t end) {
            for (size_t i = start; i < end; ++i) {
                data[i] = std::sin(data[i]) * std::sqrt(data[i]);
            }
        };
        unsigned int threads = std::thread::hardware_concurrency();
        std::vector<std::thread> pool;
        size_t chunk = size / threads;
        for (unsigned int i = 0; i < threads; ++i) {
            pool.emplace_back(worker, i * chunk, (i == threads - 1) ? size : (i + 1) * chunk);
        }
        for (auto& t : pool) t.join();
    }
};
