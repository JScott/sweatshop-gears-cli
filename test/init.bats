#!/usr/bin/env bats

@test "Downloads the Gears packages" {
  run sweatshop-gears init --path .test_download_path
  [ -f .test_download_path/README.md ]
}

@test "Exposes package binaries" {
  run sweatshop-gears init --path .test_download_path
  scripts_path=.robot_sweatshop/scripts
  [ -f $scripts_path/git-sync ]
}

@test "Doesn't expose services" {
  run sweatshop-gears init --path .test_download_path
  scripts_path=.robot_sweatshop/scripts
  [ ! -f $scripts_path/big-green-button ]
}


@test "Installs dependencies" {
  yes | gem uninstall erubis --all
  run sweatshop-gears init --path .test_download_path
  [[ $(gem list) =~ erubis ]]
}

teardown() {
  rm -rf .test_download_path
  rm -rf .robot_sweatshop
}
