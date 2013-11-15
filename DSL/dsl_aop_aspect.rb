class Object
    def aspecto(&bloque)
      asp=DslAspect.new
      asp.instance_eval(&bloque) unless bloque.nil?
      asp.getAspect
    end
    def crear(aspecto)
      aspecto
    end
end
class DslAspect
    def getAspect
      @dsl_aspecto ||= Aspect.new
    end
end