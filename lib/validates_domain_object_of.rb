require 'validates_domain_object_of/version'
require 'domain_object_argument_error'

module ValidatesDomainObjectOf
  class << self

    def construct!(domain_object_class, method, arg)
      domain_object_class.send(method.to_sym, arg)
    rescue ArgumentError
      raise DomainObjectArgumentError
    end
  end
end

require 'validates_domain_object_of/active_model' if defined?(::ActiveModel)
