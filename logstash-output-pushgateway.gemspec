Gem::Specification.new do |s|
  s.name          = 'logstash-output-pushgateway'
  s.version       = '0.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Push logstash event to pushgateway'
  s.description   = 'Build metrics and push it'
  s.homepage      = 'https://github.com/logmon/logstash-output-pushgateway'
  s.authors       = ['fsword']
  s.email         = 'li.jianye@gmail.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain", "~> 3.0"
  s.add_development_dependency "logstash-devutils", "~> 1.3"
  s.add_development_dependency "pry-nav", "~> 0.2"
end

