#!/usr/bin/env bats

setup() {
  gem build sweatshop-gears.gemspec --quiet
  gem install robot_sweatshop-gears-*.gem
}

@test "runs successfully" {
  run sweatshop-gears
  echo $status
  [ $status = 0 ]
}
