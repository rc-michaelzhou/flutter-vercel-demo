#!/usr/bin/env sh
# 将 Flutter Web 产物同步到 @vercel/static-build 约定的输出目录
set -eu
cd "$(dirname "$0")/.."

rm -rf .vercel/output/static
mkdir -p .vercel/output/static
cp -R flutter-vercel-demo/build/web/. .vercel/output/static/
