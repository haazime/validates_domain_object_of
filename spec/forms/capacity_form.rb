require 'work_time'

class CapacityForm
  include ActiveModel::Model

  attr_accessor :date, :work_time_in_minutes, :work_time_in_hours, :work_time
end
