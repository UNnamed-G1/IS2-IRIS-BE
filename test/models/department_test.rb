# == Schema Information
#
# Table name: departments
#
#  id         :bigint(8)        not null, primary key
#  name       :string(100)
#  faculty_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_departments_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
