module ValidatesDomainObjectOf
  class Railtie < Rails::Railtie
    initializer 'validates_domain_object_of.load_i18n_locales' do |_app|
      ValidatesDomainObjectOf.load_i18n_locales
    end
  end
end
