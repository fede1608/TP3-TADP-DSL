class Object
  def punto_de_corte(&bloque)
    @dsl_pc_builder= Pointcut_Builder.new
    bloque.call unless bloque.nil?
    getAspect.pointcut = @dsl_pc_builder.build
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
    leftPC=getAspect.pointcut
    punto_de_corte(&bloque)
    getAspect.pointcut = leftPC.send(met,getAspect.pointcut)
  end
end