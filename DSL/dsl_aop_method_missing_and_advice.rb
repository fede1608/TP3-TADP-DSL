  class DslAspect
    def method_missing(symbol, *args, &bloque)
      met=symbol.to_s
      if (met.start_with?('class','method'))
        @dsl_pc_builder.send(symbol,*args)
      else
        if ([:after,:before,:on_error,:instead].include?(symbol))
          getAspect.add_behaviour(symbol,bloque)
        else
          super
        end
      end
    end
    def advices(&bloque)
      bloque.call
    end
  end