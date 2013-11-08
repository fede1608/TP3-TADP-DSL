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

    class Foo7
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

    class Bar7 < Foo7
      attr_accessor :mar

      def moisture
      end

      def tomastee(colon)
      end

      def multiply(a,b)
      end
    end

    class NotFoo7
      def not_a_Foo_method

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
    Object.send :remove_const, :Foo7
    Object.send :remove_const, :Bar7
    Object.send :remove_const, :NotFoo7
    Object.subclasses.clear
  end


  it 'should Create Aspect' do
    aspect = crear aspecto
    aspect.class.should == Aspect
  end

  it 'should create an empty pointcut' do
    p= punto_de_corte
    p.class.should == Pointcut
  end

  it 'should return especific pointcut' do
    p= punto_de_corte{
      class_array [NotFoo,NotFoo2]
    }
    p.class.should == Pointcut
    p.metodos.map{|m| m.name}.should include(:not_a_Foo_method)
    p.should have(1).metodos
    p.clases.should include(NotFoo,NotFoo2)
    p.should have(2).clases
  end



  it 'should And Pointcut' do
    pc1= punto_de_corte{
      class_array [Foo7,Bar7]
      method_accessor true
    }
    pc1.metodos.map{|m| m.name}.should include(:joe,:lara,:mar,:joe=,:lara=,:mar=)
    pc1.should have(6).metodos


    pointcut_and = and_punto_de_corte{
      class_array [Foo7,Bar7]
      method_arity 1
    }
    pointcut_and.metodos.map{|m| m.name}.should include(:joe=,:lara=,:mar=)
    pointcut_and.should have(3).metodos

  end



  it 'should work' do
    a = crear aspecto {
      punto_de_corte{
        class_array [Foo,Bar]
        method_arity 2
      }
      advices{
        before{

        }
        after{

        }
        instead{

        }
        on_error{

        }
      }
    }
    a.class.should == Aspect
  end
end