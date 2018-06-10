require 'spec_helper'
require 'work_time'

RSpec.describe ValidatesDomainObjectOf do
  it do
    object = described_class.construct!(WorkTime, :new, 60 * 3)
    expect(object).to eq(WorkTime.new(60 * 3))
  end

  it do
    object = described_class.construct!(WorkTime, :parse, 5, unit: :hour)
    expect(object).to eq(WorkTime.parse(5, unit: :hour))
  end

  it do
    object = described_class.construct!(WorkTime, nil, '2') { |klass, value| klass.from_hours(value.to_i) }
    expect(object).to eq(WorkTime.from_hours('2'.to_i))
  end

  context 'raise DomainObjectArgumentError' do
    before { WorkTime.set_error_thrower(:localize) }
    after { WorkTime.set_error_thrower(:default) }

    it do
      expect { described_class.construct!(WorkTime, :new, 60 * 9,) }
        .to raise_error(DomainObjectArgumentError)
    end
  end

  context 'raise ArgumentError' do
    before { WorkTime.set_error_thrower(:default) }
    after { WorkTime.set_error_thrower(:default) }

    it do
      expect { described_class.construct!(WorkTime, :new, 60 * 9,) }
        .to raise_error(ArgumentError)
    end
  end

  context 'call undefined method' do
    it do
      expect { described_class.construct!(WorkTime, :from_jikan, 5) }
        .to raise_error(NoMethodError)
    end
  end
end
