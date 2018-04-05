class Department < ApplicationRecord
  has_many :careers
  belongs_to :faculty


  def self.get_by_faculty(faculty_id)
    where(faculty_id: faculty_id)
  end
end
