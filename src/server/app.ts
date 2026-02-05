import Fastify from 'fastify';
import { nativeEngine } from './native-bridge';

const app = Fastify();

app.post('/process', async (req, res) => {
    const size = 1_000_000;
    const sharedBuffer = new SharedArrayBuffer(size * 8);
    const array = new Float64Array(sharedBuffer);
    array.fill(Math.random());

    const start = performance.now();
    nativeEngine.runCompute(array);
    const end = performance.now();

    return { time: `${(end - start).toFixed(4)}ms`, result: array[0] };
});

app.listen({ port: 3000 });
