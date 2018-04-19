# Preview all emails at http://localhost:3000/rails/mailers/research_group_mailer
class ResearchGroupMailerPreview < ActionMailer::Preview

    def welcome_research_group
        ResearchGroupMailer.welcome_research_group(User.first, ResearchGroup.first)
    end
end
