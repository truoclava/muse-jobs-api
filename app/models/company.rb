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
  has_many :company_locations,  dependent: :destroy
  has_many :locations, through: :company_locations
  has_many :company_industries
  has_many :industries, through: :company_industries

  enum size: {
    small: 0,
    medium: 1,
    large: 2
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :size, presence: true
  validates_uniqueness_of :name

end
