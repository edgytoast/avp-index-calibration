#!/usr/bin/env bash
# Generates the project, fetches the pinned cube texture (checked by SHA-256) and builds the app.
set -euo pipefail
team="${2:?usage: scripts/build.sh --team TEAMID}"
cd "$(dirname "$0")/.."
mkdir -p App/Resources
url="https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Assets/edc7c9e67c639d230715049ee31f9a96a6babbbe/Models/Box/glTF/Box.gltf"
curl -fsSL "$url" -o App/Resources/Box.gltf
echo "4a0d69eecfce0672a50b71dc218cbacec6c53fe2445040c235c6314b1b2c41b9  App/Resources/Box.gltf" | shasum -a 256 -c - || {
  echo "Box.gltf doesn't match its pinned checksum" >&2; exit 1; }
xcodegen generate
xcodebuild -project CalibrationPort.xcodeproj -scheme CalibrationPort -destination 'generic/platform=visionOS' \
  DEVELOPMENT_TEAM="$team" build
