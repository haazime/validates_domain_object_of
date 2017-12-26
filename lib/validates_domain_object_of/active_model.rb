require 'active_model'
require 'validates_domain_object_of'

module ActiveModel
  module Validations
    class DomainObjectValidator < EachValidator
      include ValidatesDomainObjectOf::ExceptionHandler

      def validate_each(model, attr, value)
        klass = options[:object_class]
        method = options[:method] || :new

        domain_model_construction do |c|
          c.try do
            ValidatesDomainObjectOf.construct!(klass, method, value)
          end

          c.rescue_domain_object_argument_error do |msg|
            model.errors.add(attr, msg)
          end

          c.rescue_argument_error do
            model.errors.add(attr, :invalid, message: options[:message])
          end
        end
      end

      def check_validity!
        raise ArgumentError, 'Require :object_class' unless options.include?(:object_class)

        if options[:method]
          klass = options[:object_class]
          method = options[:method]
          raise ArgumentError, "`#{options[:object_class]}` is NOT respond to `#{options[:method]}`" unless klass.respond_to?(method)
        end
      end
    end

    module HelperMethods

      def validates_domain_object_of(*attr_names)
        validates_with DomainObjectValidator, _merge_attributes(attr_names)
      end
    end
  end
end
