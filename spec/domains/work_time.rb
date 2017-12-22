WorkTime = Struct.new(:minutes) do
  def self.from_hours(hours)
    new(hours * 60)
  end

  def initialize(minutes)
    raise ArgumentError if minutes > 60 * 8
    super
  end
end
