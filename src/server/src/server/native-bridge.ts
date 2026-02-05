const native = require('../../build/Release/engine.node');

export const nativeEngine = {
    runCompute: (data: Float64Array) => native.runCompute(data)
};
