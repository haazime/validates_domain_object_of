require 'validates_domain_object_of'
require 'active_model'

module ActiveModel
  module Validations
    class DomainObjectValidator < EachValidator
      def validate_each(model, attr, value)
        klass = options[:object_class]
        method = options[:method] || :new

        ValidatesDomainObjectOf.construct!(klass, method, value)

      rescue DomainObjectArgumentError => ex
        message =
          if defined?(I18n) && ex.translatable?
            I18n.t(ex.i18n_key, ex.i18n_options)
          else
            ex.message
          end
        model.errors.add(attr, message)

      rescue ArgumentError => ex
        model.errors.add(attr, :invalid, message: options[:message])
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
