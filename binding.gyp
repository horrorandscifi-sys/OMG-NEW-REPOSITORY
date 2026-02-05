{
  "targets": [{
    "target_name": "engine",
    "sources": [ "src/native/binding.cpp" ],
    "include_dirs": ["<!@(node -p \"require('node-addon-api').include\")"],
    "dependencies": ["<!(node -p \"require('node-addon-api').gyp\")"],
    "cflags_cc": [ "-std=c++17", "-O3" ]
  }]
}
