# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
    Faculty.create(
        name:  Faker::Educator.university
    )
end
10.times do
    Department.create(
        name: Faker::HarryPotter.house, 
        faculty_id: Faker::Number.between(1,10)
    )
end
10.times do
    Career.create(
        name: Faker::Educator.course,
        snies_code: Faker::Number.number(5),
        degree_type: Faker::Number.between(0,2),
        department_id: Faker::Number.between(1,10)
    )
end
10.times do
    ResearchSubject.create(
        name: Faker::Lorem.words
    )

end
