require 'work_time'

class CapacityForm
  include ActiveModel::Model

  attr_accessor :date, :work_time_in_minutes, :work_time_in_hours

  validates_domain_object_of :work_time_in_minutes, object_class: WorkTime, allow_nil: true
  validates_domain_object_of :work_time_in_hours, object_class: WorkTime, method: :from_hours, allow_nil: true
end
