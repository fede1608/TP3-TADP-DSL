class DslAspect
    def punto_de_corte(&bloque)
      @dsl_pc_builder= Pointcut_Builder.new
      self.instance_eval(&bloque) unless bloque.nil?
      getAspect.pointcut = @dsl_pc_builder.build
    end

    def crear_punto_de_corte(&bloque)
      @dsl_pc_builder= Pointcut_Builder.new
      self.instance_eval(&bloque) unless bloque.nil?
    end

    def and_punto_de_corte(&bloque)
      generic_PC(:and,&bloque)
    end

    def or_punto_de_corte(&bloque)
      generic_PC(:or,&bloque)
    end

    def not_punto_de_corte(&bloque)
      punto_de_corte(&bloque)
      getAspect.pointcut= getAspect.pointcut.not
    end

    def generic_PC(met,&bloque)
      leftPC=@dsl_pc_builder.build
      punto_de_corte(&bloque)
      getAspect.pointcut = leftPC.send(met,getAspect.pointcut)
    end

    def agregar(&bloque)
      punto_de_corte(&bloque) unless bloque.nil?
    end

    def pc_and(&bloque)
      generic_PC(:and,&bloque)
    end

    def pc_or(&bloque)
      generic_PC(:or,&bloque)
    end

    def pc_not(&bloque)
      punto_de_corte(&bloque)
      getAspect.pointcut= getAspect.pointcut.not
    end
end