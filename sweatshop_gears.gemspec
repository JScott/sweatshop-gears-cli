Gem::Specification.new do |gem|
  gem.name        = 'sweatshop_gears'
  gem.version     = '1.0.3'
  gem.licenses    = 'MIT'
  gem.authors     = ['Justin Scott']
  gem.email       = 'jvscott@gmail.com'
  gem.homepage    = 'http://www.github.com/jscott/sweatshop-gears-cli/'
  gem.summary     = 'Package management for Robot Sweatshop'
  gem.description = gem.summary

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/**/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.1'

  gem.add_runtime_dependency 'bundler'
  gem.add_runtime_dependency 'commander'
  gem.add_runtime_dependency 'robot_sweatshop'
  gem.add_runtime_dependency 'contracts'
  gem.add_runtime_dependency 'terminal-announce'
  gem.add_runtime_dependency 'git'
  gem.add_runtime_dependency 'erubis'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'riot'
  gem.add_development_dependency 'simplecov'
end
