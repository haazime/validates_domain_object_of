WorkTime = Struct.new(:minutes) do
  def self.from_hours(hours)
    new(hours * 60)
  end

  def initialize(minutes)
    raise DomainObjectArgumentError.new(nil, key: :invalid, scope: [:domain_objects, :work_time]) if minutes > 60 * 8
    super
  end
end
