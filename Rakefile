require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "hdcloud"
    gem.summary = %Q{A wrapper for interfacing with the HDCloud API}
    gem.description = %Q{An easy-to-use rubygem for managing jobs, profiles and stores in HDCloud (www.hdcloud.com).}
    gem.email = "jacqui@brighter.net"
    gem.homepage = "http://github.com/jacqui/hdcloud"
    gem.authors = ["Jacqui Maher"]
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "httparty", ">= 0"
    gem.add_development_dependency "mocha", ">= 0"
    gem.add_development_dependency "fakeweb", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "hdcloud #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
