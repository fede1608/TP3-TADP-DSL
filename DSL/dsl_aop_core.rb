require_relative('../AOP-Framework/AOPFramework')

class Object
  def aspecto(&bloque)
    bloque.call unless bloque.nil?
    getAspect
  end
  def crear(aspecto)
    aspecto
  end
  def getAspect
    @dsl_aspecto ||= Aspect.new
  end

  def punto_de_corte(&bloque)
    @dsl_pc_builder= Pointcut_Builder.new
    bloque.call unless bloque.nil?
    getAspect.pointcut = @dsl_pc_builder.build
  end
end

#Operadores Logicos
class Object
  def and_punto_de_corte(&bloque)
    generic_PC(:and,&bloque)
  end
  def or_punto_de_corte(&bloque)
    generic_PC(:or,&bloque)
  end
  def not_punto_de_corte(&bloque)
    punto_de_corte(&bloque)
    getAspect.pointcut = getAspect.pointcut.not
  end
  def generic_PC(met,&bloque)
    leftPC=getAspect.pointcut
    punto_de_corte(&bloque)
    getAspect.pointcut = leftPC.send(met,getAspect.pointcut)
  end

end

class Object
  def method_missing(symbol, *args, &bloque)
    met=symbol.to_s
    if (met.start_with?('class','method'))
      #met_params = met.split('_')
      #p met_params
      #method="#{met_params[0]}_#{met_params[1]}".to_sym
      #p met
      #params=met_params.drop(2)
      #p params
      @dsl_pc_builder.send(symbol,*args)
    else
      if ([:after,:before,:on_error,:instead].include?(symbol))
        getAspect.add_behaviour(symbol,bloque)
      else
        super
      end
    end
  end
end

class  Object
  def advices(&bloque)
     bloque.call

  end
end