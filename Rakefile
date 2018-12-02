require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Run rubocop"
task(:rubocop) do
  require "rubocop"
  RuboCop::CLI.new.run(["--config", File.join(__dir__, ".rubocop.yml")])
end

task :default => [:test, :rubocop] # rubocop:disable Style/HashSyntax, Style/SymbolArray