require 'spec_helper'
require 'capacity_form'

RSpec.describe ActiveModel::Validations::DomainObjectValidator do
  after { CapacityForm.clear_validators! }

  context 'construct by new' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_minutes, object_class: WorkTime)
    end

    it do
      form = CapacityForm.new(work_time_in_minutes: 5 * 60)
      expect(form).to be_valid
    end

    it do
      form = CapacityForm.new(work_time_in_minutes: 9 * 60)
      aggregate_failures do
        expect(form).to_not be_valid
        expect(form.errors[:work_time_in_minutes]).to match_array(['is invalid'])
      end
    end
  end

  context 'construct by from_hours' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_hours)
    end

    it do
      form = CapacityForm.new(work_time_in_hours: 5)
      expect(form).to be_valid
    end

    it do
      form = CapacityForm.new(work_time_in_hours: 9)
      aggregate_failures do
        expect(form).to_not be_valid
        expect(form.errors[:work_time_in_hours]).to match_array(['is invalid'])
      end
    end
  end

  context 'message option' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_minutes, object_class: WorkTime, message: 'wrong arg')
    end

    it do
      form = CapacityForm.new(work_time_in_minutes: 9 * 60)
      form.valid?
      expect(form.errors[:work_time_in_minutes]).to match_array(['wrong arg'])
    end
  end

  context 'invalid options' do
    it do
      expect {
        CapacityForm.validates_domain_object_of(:work_time_in_hours)
      }.to raise_error(ArgumentError)
    end

    it do
      expect {
        CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_jikan)
      }.to raise_error(ArgumentError)
    end
  end
end
