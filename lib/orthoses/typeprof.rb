# frozen_string_literal: true

require 'orthoses'
require 'typeprof'
require_relative "typeprof/version"

module Orthoses
  class TypeProf
    # use Orthoses::TypeProf,
    #   config: ::TypeProf::ConfigData.new(
    #     rb_files: rb_files,
    #     collection_path: ::RBS::Collection::Config::PATH,
    #     options: options,
    #   )
    def initialize(loader, config:)
      @loader = loader
      @config = config
    end

    def call
      @loader.call.tap do |store|
        @config.rbs_files = store.map { |name, content| [name, content.to_rbs] }
        @config.output = StringIO.new

        ::TypeProf.analyze(@config)

        content_env = Orthoses::Content::Environment.new
        buffer = ::RBS::Buffer.new(
          name: "orthoses/typeprof.rb",
          content: @config.output.string
        )
        parse(buffer) do |decl|
          content_env << decl
        end
        content_env.write_to(store: store)
      end
    end

    private

    def parse(buffer)
      _, _, decls = ::RBS::Parser.parse_signature(buffer)
      decls.each do |decl|
        # remove comment in class/module
        decl.members.each { |m| m.instance_eval { @comment = nil } }
        yield decl
      end
    end
  end
end
