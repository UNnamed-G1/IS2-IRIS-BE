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
    Schedule.create(
        start_date: Faker::Time.between(DateTime.now - 1, DateTime.now),
        end_date: Faker::Time.between(1.hour.from_now, 2.hours.from_now, :all)
    
    )
end
10.times do
    ResearchSubject.create(
        name: Faker::Lorem.words
    )

end
10.times do
    Photo.create(
        link: Faker::Lorem.sentence,
        imageable_type: Faker::Number.between(0,2)
        
    )
end
10.times do
    ResearchGroup.create(
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.sentence,
        strategic_focus: Faker::Lorem.sentence,
        research_priorities: Faker::Lorem.sentence,
        foundation_date: Faker::Time.between(DateTime.now - 10, DateTime.now),
        classification: Faker::Lorem.sentence,
        date_classification: Faker::Time.between(DateTime.now - 20, DateTime.now),
        url: Faker::Lorem.sentence,
        photo_id: Faker::Number.between(1,10)
    )

end
10.times do
    Publication.create(
        name: Faker::Lorem.sentence,
        date: Faker::Time.between(DateTime.now - 10, DateTime.now),
        abstract: Faker::Lorem.paragraph,
        url: Faker::Internet.url,
        brief_description: Faker::Lorem.sentence,
        file_name: Faker::Lorem.sentence,
        type_pub: Faker::Number.between(0,5)
    )

end
10.times do
    Event.create(
        research_group_id: Faker::Number.between(1, 10),
        topic: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        type_ev: Faker::Number.between(0,1),
        date: Faker::Time.between(DateTime.now - 20, DateTime.now),
        frequence: Faker::Number.between(0,1),
        end_time: Faker::Time.between(DateTime.now, 2.days.from_now, :all),
        state: Faker::Number.between(0,1)
    )
end
10.times do
    Relationship.create(
        follower_id: Faker::Number.between(1,10),
        followed_id: Faker::Number.between(1,10)
    )
end
10.times do
    User.create(
        name: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        email: Faker::Internet.email,
        professional_profile: Faker::Lorem.sentence,
        type_u: Faker::Number.between(0,1),
        phone: Faker::PhoneNumber.phone_number,
        office: Faker::Commerce.department,
        cvlac_link: Faker::Internet.url,
        career_id: Faker::Number.between(1,10),
        photo_id: Faker::Number.between(1,10)
    )

end

10.times do
    UserResearchGroup.create(
        joining_date: Faker::Time.between(DateTime.now - 10, DateTime.now),
        end_joining_date: Faker::Time.between(DateTime.now, 2.days.from_now, :all),
        state: Faker::Number.between(0,1),
        type_urg: Faker::Number.between(0,1),
        hours_per_week: Faker::Number.between(1,10),
        users_id: Faker::Number.between(1,10),
        research_groups_id: Faker::Number.between(1,10)
    )

end