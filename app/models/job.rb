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
#

require 'pry'

class Job < ApplicationRecord
  belongs_to :company
  has_many :job_locatons, dependent: :destroy
  has_many :locations, through: :job_locations
  has_many :job_categories
  has_many :categories, through: :job_categories

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

  before_save :set_published_timestamp, if: :published_changed?

  scope :published, -> { where(published: true) }

  def set_published_timestamp
    if published
      self.published_at ||= Time.current
    else
      self.unpublished_at ||= Time.current
    end
  end

end
