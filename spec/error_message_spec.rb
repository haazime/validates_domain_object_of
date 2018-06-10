require 'spec_helper'
require 'capacity_form'

RSpec.describe ActiveModel::Validations::DomainObjectValidator do
  subject do
    form = CapacityForm.new(work_time_in_hours: 9)
    form.valid?
    form.errors[:work_time_in_hours]
  end

  before { enalbe_i18n }

  after do
    WorkTime.set_error_thrower(:default)
    CapacityForm.clear_validators!
  end

  context 'given message option' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_hours, message: 'x')
    end

    it { is_expected.to match_array(['x']) }
  end

  context 'raw message' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_hours)
      WorkTime.set_error_thrower(:message)
    end

    it { is_expected.to match_array(['must be <= 8']) }
  end

  context 'localize' do
    before do
      CapacityForm.validates_domain_object_of(:work_time_in_hours, object_class: WorkTime, method: :from_hours)
      WorkTime.set_error_thrower(:localize)
    end

    it { is_expected.to match_array(['8時間を超えています']) }
  end

  private

    def enalbe_i18n
      ValidatesDomainObjectOf.load_i18n_locales
      I18n.backend.store_translations(
        :ja, {
          domain_objects: {
            work_time: {
              greater_than_in_hour: '%{hour}時間を超えています'
            }
          }
        }
      )
      I18n.locale = :ja
    end
end
