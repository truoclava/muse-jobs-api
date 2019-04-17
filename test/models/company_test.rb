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

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
