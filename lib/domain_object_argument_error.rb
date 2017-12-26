class DomainObjectArgumentError < ArgumentError
  attr_reader :i18n_key, :i18n_options

  def initialize(args)
    message = nil
      if args.is_a?(String)
        message = args
      else
        parse_i18n_args(args)
        @translatable = !i18n_key.nil?
      end
    super(message)
  end

  def translatable?
    @translatable
  end

  private

    def parse_i18n_args(args)
      return unless args.is_a?(Hash)
      @i18n_key = args.delete(:key)
      @i18n_options = args
    end
end
