#!/usr/bin/env bats

@test "Exposes package binaries" {
  run sweatshop-gears install git-sync --path .test_download_path
  scripts_path=.robot_sweatshop/scripts
  [ -f $scripts_path/git-sync ]
}

@test "Doesn't expose services" {
  run sweatshop-gears install big-green-button --path .test_download_path
  scripts_path=.robot_sweatshop/scripts
  [ ! -f $scripts_path/big-green-button ]
}

@test "Loads services into Eye" {
  eye stop big-green-button
  run sweatshop-gears install big-green-button --path .test_download_path
  eye start big-green-button
  sleep 3
  [[ $(eye info | grep big-green-button) =~ up ]]
}

@test "Installs dependencies" {
  skip "I need a gem to be installed that isn't used by Sweatshop or Gears"
  yes | gem uninstall SOME_GEM --all
  sweatshop-gears install git-sync --path .test_download_path
  [[ $(gem list) =~ "SOME_GEM " ]]
}

teardown() {
  rm -rf .test_download_path
}
