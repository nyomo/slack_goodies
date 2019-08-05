lib = File.expand_path("../lib",__FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_goodies/version.rb'

Gem::Specification.new do |spec|
  spec.name = "slack_goodies"
  spec.version = SlackGoodies::VERSION
  spec.date = "2019-04-23"
  spec.summary = "Slack goodies command"
  spec.description = "Slack便利コマンド "
  spec.authors = ["nyomo"]
  spec.email = 'nyomoko@gmail.com'
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end  
  spec.homepage = 'http://nyomo.go5.jp/wiki/rubygem'
  spec.license = 'MIT'

  spec.bindir = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_runtime_dependency "slack-ruby-client"
end
