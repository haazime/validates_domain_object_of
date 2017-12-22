require 'validates_domain_object_of/version'
require 'domain_object_argument_error'

module ValidatesDomainObjectOf
  class << self

    def construct!(arg, domain_object_class)
      try_construct! { domain_object_class.new(arg) }
    end

    def construct_by_factory_method!(arg, domain_object_class, method)
      try_construct! { domain_object_class.send(method.to_sym, arg) }
    end

    private

      def try_construct!
        yield
      rescue ArgumentError
        raise DomainObjectArgumentError
      end
  end
end

require 'validates_domain_object_of/active_model' if defined?(::ActiveModel)
