require "spec_helper"
require 'work_time'

RSpec.describe ValidatesDomainObjectOf do
  it do
    expect(described_class.construct!(WorkTime, :new, 60 * 3)).to be_truthy
  end

  it do
    expect { described_class.construct!(WorkTime, :new, 60 * 9,) }
      .to raise_error(DomainObjectArgumentError)
  end

  it do
    expect(described_class.construct!(WorkTime, :from_hours, 3)).to be_truthy
  end

  it do
    expect { described_class.construct!(WorkTime, :from_hours, 8.1) }
      .to raise_error(DomainObjectArgumentError)
  end

  it do
    expect { described_class.construct!(WorkTime, :from_jikan, 5) }
      .to raise_error(NoMethodError)
  end
end
