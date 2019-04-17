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

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
