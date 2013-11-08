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
end