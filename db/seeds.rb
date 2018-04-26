# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_image(file_name)
    Pathname.new("#{Rails.root}/app/assets/images/seed/#{file_name}.jpg").open
end

def seed_document(file_name)
    Pathname.new("#{Rails.root}/app/assets/documents/seed/#{file_name}.pdf").open
end

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

50.times do
    Career.create(
        name: Faker::Educator.course,
        snies_code: Faker::Number.number(5),
        degree_type: Faker::Number.between(0,2),
        department_id: Faker::Number.between(1,10)
    )
end

100.times do
    Schedule.create(
        start_hour: Faker::Number.between(0, 23),
        day_week: Faker::Number.between(0, 6),
        duration: Faker::Number.between(1, 5)
    )
end

50.times do
    ResearchSubject.create(
        name: Faker::Hacker.say_something_smart
    )
end

50.times do
    rg = ResearchGroup.create(
        name: Faker::Name.name,
        description: Faker::Lorem.sentence,
        strategic_focus: Faker::Hacker.say_something_smart,
        research_priorities: Faker::Hacker.say_something_smart,
        foundation_date: Faker::Time.backward,
        classification: Faker::Number.between(0, 3),
        date_classification: Faker::Time.backward(10),
        url: Faker::Internet.url
    )
    rg.update(photo: Photo.create(
        picture: seed_image("research_group_image"),
        imageable: rg
    ))
end


100.times do
    Publication.create(
        name: Faker::Hacker.abbreviation,
        date: Faker::Time.backward(10),
        abstract: Faker::Lorem.paragraph,
        brief_description: Faker::Hacker.say_something_smart,
        type_pub: Faker::Number.between(0,5),
        document: seed_document("publication_document")
    )
end

50.times do
    e = Event.create(
        research_group_id: Faker::Number.between(1, 50),
        topic: Faker::Lorem.sentence,
        description: Faker::Hacker.say_something_smart,
        type_ev: Faker::Number.between(0,1),
        date: Faker::Time.backward(20),
        frequence: Faker::Number.between(0,1),
        duration: "01:18:19",
        state: Faker::Number.between(0,1)
    )
    5.times do
      e.photos.create(
        picture: seed_image("event_image")
      )
    end
end

100.times do
    u = User.create(
        name: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        email: Faker::Internet.user_name+"@unal.edu.co",
        professional_profile: Faker::Lorem.paragraph,
        user_type: Faker::Number.between(0,1),
        phone: Faker::PhoneNumber.cell_phone,
        office: Faker::Commerce.department(1),
        cvlac_link: Faker::Internet.url,
        career_id: Faker::Number.between(1,50),
        password: 'password',
        password_confirmation: 'password'
    )
    u.update(photo: Photo.create(
        picture: seed_image("user_image"),
        imageable: u
    ))
end

100.times do
    Relationship.create(
        follower_id: Faker::Number.between(1,100),
        followed_id: Faker::Number.between(1,100)
    )
end

100.times do
   UserResearchGroup.create(
        joining_date: Faker::Time.backward(10),
        end_joining_date: Faker::Time.forward(2),
        state: Faker::Number.between(0,1),
        type_urg: Faker::Number.between(0,1),
        user_id: Faker::Number.between(1,100),
        research_group_id: Faker::Number.between(1,50)
    )
end

30.times do
    EventUser.create(
        type_user_event: Faker::Number::between(0, 2),
        user_id: Faker::Number.between(1,10),
        event_id: Faker::Number.between(1,10)
    )
end

User.all.each do |usr|
    usr.schedules = Schedule.all.sample(rand(0..3))
end

User.all.each do |usr|
    usr.research_subjects = ResearchSubject.all.sample(rand(0..3))
end

Publication.all.each do |p|
    p.research_groups = ResearchGroup.all.sample(rand(0..3))
end

Career.all.each do |car|
    car.research_groups = ResearchGroup.all.sample(rand(0..3))
end

ResearchSubject.all.each do |rs|
    rs.research_groups = ResearchGroup.all.sample(rand(0..3))
end

User.all.each do |usr|
    usr.publications = Publication.all.sample(rand(0..3))
end

User.create(
    name: "admin",
    lastname: "admin",
    email: "admin@unal.edu.co",
    password: 'admin',
    password_confirmation: 'admin',
    user_type: 'admin'
)
