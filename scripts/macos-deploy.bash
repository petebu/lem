#!/usr/bin/env bash
# scripts/macos-deploy.bash

set -euxo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
parent_dir="$(dirname "$script_dir")"
cd "$parent_dir"

rm -rf "bin/Lem.app"

qlot install
qlot exec sbcl --eval '(ql:quickload :lem)' --eval '(asdf:make :lem)'

codesign --force --deep --sign - "bin/Lem.app"

README_PATH="bin/README.md"
echo 'The following command must be executed for Lem.app to start.
```
xattr -dr com.apple.quarantine Lem.app/
```
' > "$README_PATH"

rm -f lem-macos.zip
(
  cd bin
  zip -r ../lem-macos.zip "Lem.app" "README.md"
)
echo "Packaged: $(pwd)/lem-macos.zip"
