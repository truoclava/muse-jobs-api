# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  city       :string
#  state      :string
#  country    :string
#  remote     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
