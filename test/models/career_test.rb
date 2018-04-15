# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(100)      not null
#  snies_code    :integer          not null
#  degree_type   :integer          default("pregado"), not null
#  department_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_careers_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (department_id => departments.id)
#

require 'test_helper'

class CareerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
