require 'pathname'
require 'fileutils'
require 'orthoses/typeprof'

include FileUtils

out = Pathname('out')
out.rmtree rescue nil
Orthoses::Builder.new do
  use Orthoses::CreateFileByName,
    base_dir: out.to_s
  use Orthoses::Filter do |name, content|
    name.start_with?("Rack::Test")
  end
  use Orthoses::TypeProf,
    config: ::TypeProf::ConfigData.new(
      rb_files: ["src/lib/rack/test.rb"],
      collection_path: ::RBS::Collection::Config::PATH,
    )
  run ->(){}
end.call
