#!/usr/bin/env bats

# gem build sweatshop-gears.gemspec --quiet
# gem install robot_sweatshop-gears-*.gem

@test "Runs" {
  run sweatshop-gears
  [ $status = 0 ]
}
