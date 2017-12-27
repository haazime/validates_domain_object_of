WorkTime = Struct.new(:minutes) do
  class << self
    attr_accessor :error_thrower

    def parse(value, unit:)
      return new(value) if unit.to_sym == :minutes
      from_hours(value)
    end

    def from_hours(hours)
      new(hours * 60)
    end

    ERROR_THROWERS = {
      default: -> (_h) { raise ArgumentError },
      message: -> (h) { raise DomainObjectArgumentError.new("must be <= #{h}") },
      localize: -> (h) {
        raise DomainObjectArgumentError.i18n(:greater_than_in_hour, hour: h, scope: [:domain_objects, :work_time])
      }
    }

    def set_error_thrower(key)
      @error_thrower = ERROR_THROWERS[key]
    end
  end

  def initialize(minutes)
    self.class.error_thrower.call(8) if minutes > 60 * 8
    super
  end
end

WorkTime.set_error_thrower(:default)
