module ValidatesDomainObjectOf
  class Context

    def initialize
      @construction = nil
      @callbacks = {}
    end

    def run!
      @construction.call
    rescue DomainObjectArgumentError => ex
      message =
        if defined?(I18n) && ex.translatable?
          message = I18n.t(ex.i18n_key, ex.i18n_options)
        else
          message = ex.message
        end
      callback(:domain_object_argument_error, message)

    rescue ArgumentError
      callback(:argument_error)
    end

    def try(&block)
      @construction = block
    end

    def rescue_domain_object_argument_error(&block)
      @callbacks[:domain_object_argument_error] = block
    end

    def rescue_argument_error(&block)
      @callbacks[:argument_error] = block
    end

    private

      def callback(key, *args)
        @callbacks[key].call(*args)
      end
  end

  module ExceptionHandler

    def domain_model_construction
      context = Context.new
      yield(context)
      context.run!
    end
  end
end
