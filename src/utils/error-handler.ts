export const handleError = (err: any) => {
    console.error(`[ERROR]: ${err.message}`);
    process.exit(1);
};
