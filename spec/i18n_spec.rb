require 'spec_helper'
require 'capacity_form'

RSpec.describe ActiveModel::Validations::DomainObjectValidator do
  after { CapacityForm.clear_validators! }

  xit do
    CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_hours)
    form = CapacityForm.new(work_time_in_hours: 9)
    form.valid?
    expect(form.errors[:work_time_in_hours]).to match_array(['8時間を超えています'])
  end
end