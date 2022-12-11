class Foo
  attr_accessor :a, :b

  def initialize
    @a = 1
  end

  def ten(arg)
    arg * 10
  end

  def ref
    import2
  end
end

foo = Foo.new
foo.b = "test"
foo.ten(2)
foo.ten(2.1)
foo.ten("a")
