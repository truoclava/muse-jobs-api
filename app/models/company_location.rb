# == Schema Information
#
# Table name: company_locations
#
#  company_id  :integer          not null
#  location_id :integer          not null
#

class CompanyLocation < ApplicationRecord
  belongs_to :company
  belongs_to :location
end
