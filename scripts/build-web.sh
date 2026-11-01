#!/usr/bin/env sh
# 编译 Flutter Web 产物（release 模式），输出在 flutter-vercel-demo/build/web
set -eu
cd "$(dirname "$0")/.."

cd flutter-vercel-demo
"$HOME/flutter/bin/flutter" build web --release
