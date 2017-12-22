require 'spec_helper'
require 'capacity_form'

RSpec.describe ActiveModel::Validations::DomainObjectValidator do
  it do
    form = CapacityForm.new(work_time_in_minutes: 5 * 60)
    expect(form).to be_valid
  end

  it do
    form = CapacityForm.new(work_time_in_minutes: 9 * 60)
    expect(form).to_not be_valid
  end
end
