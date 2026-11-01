#!/usr/bin/env sh
# Vercel 构建总入口：安装 SDK → 编译 Web → 拷贝产物
set -eu
cd "$(dirname "$0")/.."

sh scripts/install-flutter.sh
sh scripts/build-web.sh
sh scripts/copy-output.sh
