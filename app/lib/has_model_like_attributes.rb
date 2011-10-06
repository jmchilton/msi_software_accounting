require 'basic_model'

module HasModelLikeAttributes

  def [](attribute)
    if self.respond_to?("#{attribute}")
      value = send attribute
    else
      value = instance_variable_get "@#{attribute}"
    end
    value
  end

  def []=(attribute, value)
    if !self.respond_to?("#{attribute}=")
      metaclass = class << self; self; end
      metaclass.send :attr_accessor, "#{attribute}".to_sym
    end
    send "#{attribute}=", value
  end

  def attributes
    instance_values
  end

end