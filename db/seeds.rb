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
        url: Faker::Internet.url,
        state: Faker::Number.between(0, 1)
    )
    rg.update(photo: Photo.create(
        picture: seed_image("research_group_image"),
        imageable: rg
    ))
end

1000.times do
    Publication.create(
        name: Faker::Hacker.abbreviation,
        date: Faker::Time.backward(180),
        abstract: Faker::Lorem.paragraph,
        brief_description: Faker::Hacker.say_something_smart,
        publication_type: Faker::Number.between(0,5),
        distinction_type: Faker::Number.between(0,2),
        document: seed_document("publication_document"),
        state: Faker::Number.between(0,2)
    )
end

50.times do
    e = Event.create(
        research_group_id: Faker::Number.between(1, 50),
        name: Faker::Name.name,
        topic: Faker::Lorem.sentence,
        description: Faker::Hacker.say_something_smart,
        event_type: Faker::Number.between(0,1),
        date: Faker::Time.forward(20),
        frequence: Faker::Number.between(0,1),
        duration: "01:18:19",
        state: Faker::Number.between(0,1),
        latitude:  Float(4.63858),
        longitude: Float(-74.0841)
    )
    5.times do
      e.photos.create(
        picture: seed_image("event_image")
      )
    end
end

index = 0
100.times do
    u = User.create(
        name: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        username: "user#{index}",
        email: "user#{index}@unal.edu.co",
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
    index += 1
end

100.times do
    Relationship.create(
        follower_id: Faker::Number.between(1,100),
        followed_id: Faker::Number.between(1,100)
    )
end

100.times do
    p = PublicationUser.create(
        publication_id: Faker::Number.between(1,100),
        user_id: Faker::Number.between(1,100)
        
    )
    prg = PublicationResearchGroup.create(
        publication_id: p.publication_id,
        research_group_id: Faker::Number.between(1,50)
    )    
    u = UserResearchGroup.create(
        joining_date: Faker::Time.backward(10),
        state: 0,
        member_type: Faker::Number.between(0,1),
        user_id: p.user_id,
        research_group_id: prg.research_group_id
    )
end

30.times do
    EventUser.create(
        type_user_event: Faker::Number::between(0, 2),
        user_id: Faker::Number.between(1,100),
        event_id: Faker::Number.between(3,50)
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

##Default users

User.create(
    name: "admin",
    lastname: "admin",
    email: "admin@unal.edu.co",
    password: 'admin',
    password_confirmation: 'admin',
    user_type: 'Administrador'
)
leader = User.create(
    name: "Juan",
    lastname: "Cruz",
    username: "leader",
    email: "leader"+"@unal.edu.co",
    professional_profile: Faker::Lorem.paragraph,
    user_type: "Profesor",
    phone: Faker::PhoneNumber.cell_phone,
    office: Faker::Commerce.department(1),
    cvlac_link: Faker::Internet.url,
    career_id: 3,
    password: 'password',
    password_confirmation: 'password'
)
leader.update(photo: Photo.create(
    picture: seed_image("user_image"),
    imageable: leader
))
student = User.create(
    name: "Mario",
    lastname: "Rojas",
    username: "student",
    email: "student"+"@unal.edu.co",
    professional_profile: Faker::Lorem.paragraph,
    user_type: "Estudiante",
    phone: Faker::PhoneNumber.cell_phone,
    office: Faker::Commerce.department(1),
    cvlac_link: Faker::Internet.url,
    career_id: 6,
    password: 'password',
    password_confirmation: 'password'
)
student.update(photo: Photo.create(
    picture: seed_image("user_image"),
    imageable: student
))


#Professor will be leader of one group and member but not leader 
#of three other groups by default, as well as the student will belong to 3 research groups

UserResearchGroup.create(
    joining_date: Faker::Time.backward(10),
    state: 0,
    member_type: "Líder",
    user_id: leader.id,
    research_group_id: 1
)

#Linking default users to research groups as members

3.times do

    UserResearchGroup.create(
        joining_date: Faker::Time.backward(8),
        state: 0,
        member_type: "Miembro",
        user_id: student.id,
        research_group_id: Faker::Number.between(1,50)
    )

    UserResearchGroup.create(
        joining_date: Faker::Time.backward(10),
        state: 0,
        member_type: "Miembro",
        user_id: leader.id,
        research_group_id: Faker::Number.between(2,50)
    )  

end

#Linking publications to default users

20.times do
    PublicationUser.create(
        publication_id: Faker::Number.between(1,100),
        user_id: student.id  
    )
    PublicationUser.create(
        publication_id: Faker::Number.between(1,100),
        user_id: leader.id
    )
end

#Linking research subjects to default users

4.times do
    ResearchSubjectUser.create(
        user_id: student.id,
        research_subject_id: Faker::Number.between(1,50)
    )
    ResearchSubjectUser.create(
        user_id: leader.id,
        research_subject_id: Faker::Number.between(1,50)
    )
end

##Linking events to default users

5.times do 
    EventUser.create(
        type_user_event: Faker::Number.between(0,1),
        user_id: student.id,
        event_id: Faker::Number.between(1,50)
    )
    EventUser.create(
        type_user_event: Faker::Number.between(0,1),
        user_id: leader.id,
        event_id: Faker::Number.between(3,50)
    )              
end

##Default leader will be author of first two events

EventUser.create(
    type_user_event: 2,
    user_id: leader.id,
    event_id: 1
)

EventUser.create(
    type_user_event: 2,
    user_id: leader.id,
    event_id: 2
)
