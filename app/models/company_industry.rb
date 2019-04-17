# == Schema Information
#
# Table name: company_industries
#
#  company_id  :integer          not null
#  industry_id :integer          not null
#

class CompanyIndustry < ApplicationRecord
  belongs_to :company
  belongs_to :industry
end
