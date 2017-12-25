class DomainObjectArgumentError < ArgumentError
  attr_reader :i18n_key, :i18n_scope

  def initialize(message = nil, key: nil, scope: [])
    @i18n_key = key
    @i18n_scope = scope
    @translatable = !key.nil?
    super(message)
  end

  def translatable?
    @translatable
  end
end
