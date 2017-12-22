require 'validates_domain_object_of'
require 'active_model'

module ActiveModel
  module Validations
    class DomainObjectValidator < EachValidator

      def validate_each(model, attr, value)
        ValidatesDomainObjectOf.construct!(value, options[:object_class])
      rescue DomainObjectArgumentError => error
        model.errors.add(attr, :invalid)
      end
    end

    module HelperMethods

      def validates_domain_object_of(*attr_names)
        validates_with DomainObjectValidator, _merge_attributes(attr_names)
      end
    end
  end
end