Gem::Specification.new do |gem|
  gem.name        = 'sweatshop-tears'
  gem.version     = '0.0.1'
  gem.licenses    = 'MIT'
  gem.authors     = ['Justin Scott']
  gem.email       = 'jvscott@gmail.com'
  gem.homepage    = 'http://www.github.com/jscott/sweatshop-tears-cli/'
  gem.summary     = 'Robot Sweatshop'
  gem.description = 'Package management for Robot Sweatshop'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test/**/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 2.1'

  gem.add_runtime_dependency 'bundler'
  gem.add_runtime_dependency 'commander'
  gem.add_runtime_dependency 'robot_sweatshop'
  gem.add_runtime_dependency 'contracts'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'riot'
  gem.add_development_dependency 'simplecov'
end
