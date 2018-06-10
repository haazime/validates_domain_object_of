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

  context 'construct by from_hours with proc' do
    before do
      CapacityForm.validates_domain_object_of(
        :work_time_in_hours,
        object_class: WorkTime,
        by: -> (klass, value) { klass.from_hours(value.to_i) }
      )
    end

    it do
      form = CapacityForm.new(work_time_in_hours: '5')
      expect(form).to be_valid
    end

    it do
      form = CapacityForm.new(work_time_in_hours: '9')
      aggregate_failures do
        expect(form).to_not be_valid
        expect(form.errors[:work_time_in_hours]).to match_array(['is invalid'])
      end
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

  describe 'Keep valid object' do
    before do
      CapacityForm.class_eval { attr_accessor :domain_objects }
      CapacityForm.validates_domain_object_of(:date, object_class: Date, method: :parse)
      CapacityForm.validates_domain_object_of(:work_time, object_class: WorkTime, by: -> (k, v) { k.from_hours(v.to_f) })
    end

    it do
      form = CapacityForm.new(date: '2018-01-01', work_time: '0.5')
      form.validate
      aggregate_failures do
        expect(form.domain_objects[:date]).to eq(Date.parse('2018-01-01'))
        expect(form.domain_objects[:work_time]).to eq(WorkTime.new(30))
      end
    end
  end
end
