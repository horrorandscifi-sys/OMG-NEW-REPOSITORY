test('C++ Engine should process data', () => {
    const data = new Float64Array([1, 2, 3]);
    // вызов натива
    expect(data[0]).not.toBe(1);
});
