#!/usr/bin/env sh
# 幂等安装 Flutter SDK（Vercel 构建环境未预装 Flutter）
# 用法：默认锁定 3.47.9；需要临时改版本时传入 tag，如 FLUTTER_VERSION=stable npm run build
set -eu

FLUTTER_DIR="$HOME/flutter"
FLUTTER_VERSION="${FLUTTER_VERSION:-3.47.9}"

# 防止 dart CLI 在 flutter 命令时自行重复下载 Dart SDK
export DART_CLI_SKIP_DART_SDK=true

# 已存在的 SDK 版本：git describe 拿当前检出的 tag（如 3.47.9）
existing_version="none"
[ -d "$FLUTTER_DIR/.git" ] && existing_version="$(git -C "$FLUTTER_DIR" describe --tags 2>/dev/null || echo unknown)"

# 跳过克隆的条件：目录已存在，且（目标是不锁版本的 stable，或已装版本正好匹配）
if [ "$existing_version" != none ] && \
   { [ "$FLUTTER_VERSION" = stable ] || [ "$existing_version" = "$FLUTTER_VERSION" ]; }; then
    echo "Flutter SDK present ($existing_version), skipping clone"
else
    # 版本不匹配时先删除旧 SDK，保证 --depth 1 浅克隆能切换到指定 tag
    rm -rf "$FLUTTER_DIR"
    git clone --depth 1 -b "$FLUTTER_VERSION" https://github.com/flutter/flutter.git "$FLUTTER_DIR"
fi

"$FLUTTER_DIR/bin/flutter" --disable-analytics
"$FLUTTER_DIR/bin/flutter" --version
