module ValidatesDomainObjectOf
  class Context

    def initialize
      @error_handlers = {}
    end

    def try!
      yield
    rescue DomainObjectArgumentError => ex
      handle_error(:translatable, convert_to_message(ex))
    rescue ArgumentError
      handle_error(:generic)
    end

    def rescue_translatable_error(&block)
      register_error_handler(:translatable, &block)
    end

    def rescue_generic_error(&block)
      register_error_handler(:generic, &block)
    end

    private

      def register_error_handler(key, &block)
        @error_handlers[key] = block
      end

      def handle_error(key, *args)
        return unless @error_handlers.key?(key)
        @error_handlers[key].call(*args)
      end

      def convert_to_message(exception)
        if defined?(I18n) && exception.translatable?
          I18n.t(exception.i18n_key, exception.i18n_options)
        else
          exception.message
        end
      end
  end
end
