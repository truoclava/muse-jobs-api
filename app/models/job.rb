# == Schema Information
#
# Table name: jobs
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  level          :integer
#  published      :boolean          default(FALSE)
#  published_at   :datetime
#  unpublished_at :datetime
#  company_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  api_id         :string
#  api_source     :string
#

require 'pry'

class Job < ApplicationRecord
  include JobFiltersConcern

  belongs_to :company, autosave: true
  has_many :job_locations, dependent: :destroy
  has_many :locations, through: :job_locations
  has_many :job_categories
  has_many :categories, through: :job_categories

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :locations
  # accepts_nested_attributes_for :company

  enum level: {
    internship: 0,
    entry: 1,
    mid: 2,
    senior: 3
  }

  validates :title, presence: true
  validates :company_id, presence: true
  validates :level, presence: true, if: proc { |r| r.published? }
  validates :description, presence: true, if: proc { |r| r.published? }
  after_validation :set_associated_records

  before_save :set_published_timestamp, if: :published_changed?

  scope :published, -> { where(published: true) }
  scope :with_level, -> (levels) { where(level: levels) }

  def set_published_timestamp
    if published
      self.published_at ||= Time.current
    else
      self.unpublished_at ||= Time.current
    end
  end

  def set_associated_records
    self.locations = locations.map do |obj|
      Location.where(name: obj.name).first_or_initialize
    end

    self.categories = categories.map do |obj|
      Category.where(name: obj.name).first_or_initialize
    end
  end

end
