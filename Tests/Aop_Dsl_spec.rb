require 'rspec'
require_relative('../DSL/dsl_aop_core')


describe 'DSL Aspect' do

  before :each do
    class Foo
      attr_accessor :joe,:lara

      def another
      end

      def other(sth)
      end

      def not_true
      end

      def not_false
      end

    end

    class Bar < Foo
      attr_accessor :mar

      def moisture
      end

      def tomastee(colon)
      end

      def multiply(a,b)
      end
    end

    class NotFoo
      def not_a_Foo_method

      end
    end
    class NotFoo2

    end
    class Foo8
      attr_accessor :joe,:lara

      def another
      end

      def other(sth)
      end

      def not_true
      end

      def not_false
      end

    end

    class Bar8 < Foo8
      attr_accessor :mar

      def moisture
      end

      def tomastee(colon)
      end

      def multiply(a,b)
      end
    end

    class Fight8 < Foo8
      attr_accessor :sol

      def moisture2
      end

      def tomastee2(colon)
      end

    end

  end
  after do
    Object.send :remove_const, :Foo8
    Object.send :remove_const, :Fight8
    Object.send :remove_const, :Foo
    Object.send :remove_const, :Bar
    Object.send :remove_const, :Bar8
    Object.send :remove_const, :NotFoo
    Object.subclasses.clear
  end


  it 'should Create Aspect' do
    aspect = nuevo aspecto
    aspect.class.should == Aspect
  end

  it 'should return especific pointcut' do
    p= clases_particulares NotFoo,NotFoo2
    p.class.should == Pointcut
    p.metodos.map{|m| m.name}.should include(:not_a_Foo_method)
    p.should have(1).metodos
    p.clases.should include(NotFoo,NotFoo2)
    p.should have(2).clases
  end

  it 'should create a pointcut' do
    p= con punto_de_corte en
    p.class.should == Pointcut
  end
end