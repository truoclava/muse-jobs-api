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

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
