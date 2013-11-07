require_relative('../AOP-Framework/AOPFramework')

class  Object
  def aspecto(pointcut = Pointcut.new)
    a= Aspect.new
    a.pointcut=pointcut
    a
  end
  def nuevo(aspecto)
    aspecto
  end
end

class Object
  def clases_particulares(*clases)
    Pointcut_Builder.new.class_array(clases).build
  end
end