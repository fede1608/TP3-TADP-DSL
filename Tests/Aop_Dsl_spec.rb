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
      attr_accessor :joe7,:lara7

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
      attr_accessor :mar7

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


  it 'should return especific pointcut' do
    aspect=crear aspecto{
    punto_de_corte{
      class_array [NotFoo,NotFoo2]
    }
    }
    aspect.pointcut.class.should == Pointcut
    aspect.pointcut.metodos.map{|m| m.name}.should include(:not_a_Foo_method)
    aspect.pointcut.should have(1).metodos
    aspect.pointcut.clases.should include(NotFoo,NotFoo2)
    aspect.pointcut.should have(2).clases
  end



  it 'should And Pointcut' do
    aspect=crear aspecto{
      punto_de_corte{
        class_array [Foo7,Bar7]
        method_accessor true
      }
      #pc1.metodos.map{|m| m.name}.should include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
      #pc1.should have(6).metodos


      pointcut_and = and_punto_de_corte{
        class_array [Foo7,Bar7]
        method_arity 1
      }
      #pointcut_and.metodos.map{|m| m.name}.should include(:joe7=,:lara7=, :other, :mar7=, :tomastee)
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(3).metodos

  end

  it 'should And Pointcut reloaded' do
    aspect=crear aspecto{
      crear_punto_de_corte{
        class_array [Foo7,Bar7]
        method_accessor true
        pc_and{
          class_array [Foo7,Bar7]
          method_arity 1
        }
      }
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(3).metodos

  end


  it 'should OR 2 pointcuts' do
    aspect=crear aspecto{
    punto_de_corte{
      class_array [Foo7,Bar7]
      method_accessor true
    }

    or_punto_de_corte{
      class_array [Foo7,Bar7]
      method_arity 1
    }
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.metodos.map{|m| m.name}.should include(:tomastee,:other,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(8).metodos
  end

  it 'should OR 2 pointcuts reloaded' do
    aspect=crear aspecto{
      crear_punto_de_corte{
        class_array [Foo7,Bar7]
        method_accessor true
        pc_or{
          class_array [Foo7,Bar7]
          method_arity 1
        }
      }
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.metodos.map{|m| m.name}.should include(:tomastee,:other,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(8).metodos
  end

  it 'should Negate(NOT) a pointcut' do
    aspect=crear aspecto{
    punto_de_corte{
      class_array([Foo7,Bar7])
      method_accessor(true)
    }
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(6).metodos

    aspect=crear aspecto{
      not_punto_de_corte{
        class_array([Foo7,Bar7])
        method_accessor(true)
      }
    }
    #pointcut_not.metodos.map{|m| m.name}.should include(:tomastee,:other,:not_true,:not_false,:not_a_Foo_method,:another,:moisture,:multiply)
    aspect.pointcut.metodos.map{|m| m.name}.should_not include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
  end

  it 'should Negate(NOT) a pointcut reloaded' do
    aspect=crear aspecto{
      crear_punto_de_corte{
        class_array([Foo7,Bar7])
        method_accessor(true)
      }
    }
    aspect.pointcut.metodos.map{|m| m.name}.should include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
    aspect.pointcut.should have(6).metodos

    aspect=crear aspecto{
      crear_punto_de_corte{
        pc_not{
          class_array([Foo7,Bar7])
          method_accessor(true)
        }
      }
    }
    #pointcut_not.metodos.map{|m| m.name}.should include(:tomastee,:other,:not_true,:not_false,:not_a_Foo_method,:another,:moisture,:multiply)
    aspect.pointcut.metodos.map{|m| m.name}.should_not include(:joe7,:lara7,:mar7,:joe7=,:lara7=,:mar7=)
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