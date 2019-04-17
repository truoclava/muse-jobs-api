# == Schema Information
#
# Table name: job_categories
#
#  job_id      :integer          not null
#  category_id :integer          not null
#


class JobCategory < ApplicationRecord
  belongs_to :job
  belongs_to :category
end
