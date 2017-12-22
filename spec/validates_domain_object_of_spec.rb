require "spec_helper"
require 'work_time'

RSpec.describe ValidatesDomainObjectOf do
  it do
    expect(described_class.construct!(60 * 3, WorkTime)).to be_truthy
  end

  it do
    expect { described_class.construct!(60 * 9, WorkTime) }
      .to raise_error(DomainObjectArgumentError)
  end

  it do
    expect(described_class.construct_by_factory_method!(3, WorkTime, :from_hours)).to be_truthy
  end

  it do
    expect { described_class.construct_by_factory_method!(8.1, WorkTime, :from_hours) }
      .to raise_error(DomainObjectArgumentError)
  end
end
