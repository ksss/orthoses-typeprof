# frozen_string_literal: true

require "bundler/gem_tasks"
require "rgot/cli"

task :test do
  require 'orthoses/typeprof'
  Orthoses.logger.level = :error
  Orthoses::Utils.rbs_environment
  Rgot::Cli.new(%w[-v lib]).run
end

task :sig do
  require 'orthoses/typeprof'
  require 'typeprof'
  Orthoses::Builder.new do
    use Orthoses::CreateFileByName,
      base_dir: "sig"
    use Orthoses::TypeProf,
      config: TypeProf::ConfigData.new(
        rb_files: Dir["lib/**/*.rb"]
      )
    run -> { }
  end.call
end

task default: :test
