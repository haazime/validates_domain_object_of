require 'spec_helper'
require 'work_time'

RSpec.describe ValidatesDomainObjectOf do
  it do
    expect(described_class.construct!(WorkTime, :new, 60 * 3)).to be_truthy
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
