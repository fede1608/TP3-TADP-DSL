require 'rspec'
require_relative '../DSL/dsl_aop_core'

describe 'basic aspects' do

  before :each do
    class Foo2
      attr_accessor :algo,:otro
      def initialize
        @algo=4
        @otro=7
      end
      def heavy
        10000.times do
          Math.sqrt(1000)
        end
      end
    end
    class Bar2 < Foo2
      def shit
        raise('un error')
      end
    end

    @foo=Foo2.new
    @bar=Bar2.new

  end
  after do
    Object.send :remove_const, :Foo2
    Object.send :remove_const, :Bar2
    Object.subclasses.clear
  end

  it 'should aspect before' do
    beforeAspect=crear aspecto{
                    punto_de_corte {
                    class_array [Foo2,Bar2]
                    method_arity 1
                    }
                    advices{
                      before{
                          |met,*args| met.receiver.instance_variable_set(:@algo,*args)
                      }
                    }
                  }
    @foo.otro=(-1)
    @foo.algo.should ==  -1
  end

  it 'should aspect after' do
    afterAspect=crear aspecto{
      punto_de_corte {
        class_array [Foo2,Bar2]
        method_array [:heavy]
      }
      advices{
        after{
            |met,res| met.receiver.instance_variable_set(:@algo,res)
        }
      }
    }
    @foo.heavy
    @foo.algo.should ==  10000
  end

  it 'should aspect instead' do
    @foo.algo.should ==  4
    errorAspect=crear aspecto{
      punto_de_corte {
        class_array [Foo2,Bar2]
        method_accessor true
      }
      advices{
        instead{
            |met,old_met,*args| 90
        }
      }
    }
    @foo.algo.should ==  90
  end

  it 'should aspect on error' do
    errorAspect=crear aspecto{
      punto_de_corte {
        class_array [Foo2,Bar2]
      }
      advices{
        on_error{
            |met,e| e
        }
      }
    }
    @bar.shit.should_not  raise_exception
  end
end