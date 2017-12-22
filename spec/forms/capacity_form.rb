require 'work_time'

class CapacityForm
  include ActiveModel::Model

  attr_accessor :date, :work_time_in_minutes

  validates_domain_object_of :work_time_in_minutes, object_class: WorkTime
end
