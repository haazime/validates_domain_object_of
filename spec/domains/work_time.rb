WorkTime = Struct.new(:minutes) do
  class << self
    attr_accessor :error_thrower

    def from_hours(hours)
      new(hours * 60)
    end

    ERROR_THROWERS = {
      default: -> { raise ArgumentError },
      custom: -> { raise DomainObjectArgumentError(key: :invalid, scope: [:domain_objects, :work_time]) }
    }

    def set_error_thrower(key)
      @error_thrower = ERROR_THROWERS[key]
    end
  end

  def initialize(minutes)
    self.class.error_thrower.call if minutes > 60 * 8
    super
  end
end

WorkTime.set_error_thrower(:default)
