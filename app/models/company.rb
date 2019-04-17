# == Schema Information
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  size        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  api_id      :string
#  api_source  :string
#

# == Schema e
#
# Table name: companies
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  size        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Company < ApplicationRecord
  has_many :jobs
  has_many :company_locations, dependent: :destroy
  has_many :locations, through: :company_locations
  has_many :company_industries, dependent: :destroy
  has_many :industries, through: :company_industries

  accepts_nested_attributes_for :industries
  accepts_nested_attributes_for :locations

  enum size: {
    small: 0,
    medium: 1,
    large: 2
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :size, presence: true
  validates_uniqueness_of :name # with scope of city?
  after_validation :set_associated_records

  def set_associated_records
    self.locations = locations.map do |obj|
      Location.where(name: obj.name).first_or_initialize
    end

    self.industries = industries.map do |obj|
      Industry.where(name: obj.name).first_or_initialize
    end
  end

  # def autosave_associated_records_for_industries
  #   # industries are saved
  #   # company is saved
  #   # locations are saved
  #   # company locations are saved
  #   # being hit AFTER company record is saved. need to hit before.
  # end


end
