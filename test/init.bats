#!/usr/bin/env bats

@test "Downloads the Gears packages" {
  run sweatshop-gears init --path .test_download_path
  [ -f .test_download_path/README.md ]
}

teardown() {
  rm -rf .test_download_path
}
