# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  city       :string
#  state      :string
#  country    :string
#  remote     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Location < ApplicationRecord
  has_many :job_locations
  has_many :company_locations
  has_many :jobs, through: :job_locations
  has_many :companies, through: :company_locations
end
