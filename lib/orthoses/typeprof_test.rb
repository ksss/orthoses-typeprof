module TypeProfTest
  def test_typeprof(t)
    store = Orthoses::TypeProf.new(
      Orthoses::LoadRBS.new(
        -> () { Orthoses::Utils.new_store },
        paths: [File.expand_path("../../../test/foo.rbs", __FILE__)]
      ),
      config: TypeProf::ConfigData.new(
        rb_files: [File.expand_path("../../../test/foo.rb", __FILE__)]
      )
    ).call

    actual = store.map { |n, c| c.to_rbs }.join("\n")
    expect = <<~RBS
      class Foo
        attr_accessor imported_accessor: String
        def import1: () -> void
        def import2: () -> bool
        attr_accessor a: Integer
        attr_accessor b: String
        def initialize: () -> void
        def ten: (Float | Integer | String arg) -> (Float | Integer | String)
        def ref: () -> bool
      end
    RBS
    unless expect == actual
      t.error("expect=\n```rbs\n#{expect}```\n, but got \n```rbs\n#{actual}```\n")
    end
  end
end
