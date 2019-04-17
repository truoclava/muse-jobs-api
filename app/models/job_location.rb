# == Schema Information
#
# Table name: job_locations
#
#  job_id      :integer          not null
#  location_id :integer          not null
#

class JobLocation < ApplicationRecord
  belongs_to :job
  belongs_to :location
end
