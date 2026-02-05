#include <napi.h>
#include "../core/engine.hpp"

Napi::Value RunCompute(const Napi::CallbackInfo& info) {
    Napi::Env env = info.Env();
    Napi::Float64Array buf = info[0].As<Napi::Float64Array>();
    double* data = buf.Data();
    size_t len = buf.ElementLength();

    ComputeEngine::ParallelProcess(data, len);

    return Napi::Boolean::New(env, true);
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    exports.Set("runCompute", Napi::Function::New(env, RunCompute));
    return exports;
}

NODE_API_MODULE(engine, Init)
