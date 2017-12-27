require 'validates_domain_object_of/version'
require 'validates_domain_object_of/context'
require 'domain_object_argument_error'

module ValidatesDomainObjectOf
  class << self
    def load_i18n_locales
      require 'i18n'
      I18n.load_path += Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), '../config/locales/*.yml')))
    end

    def construct!(domain_object_class, method, *args)
      domain_object_class.send(method.to_sym, *args)
    end

    def construct_with!(*args)
      context = Context.new
      yield(context)
      context.try! { construct!(*args) }
    end
  end
end

require 'validates_domain_object_of/active_model' if defined?(::ActiveModel)
require 'validates_domain_object_of/railtie' if defined?(::Rails::Railtie)
