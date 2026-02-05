export const CONFIG = {
    PORT: process.env.PORT || 3000,
    THREADS: require('os').cpus().length
};
