class ContactMailer < ActionMailer::Base
    default to : 'theteam@leedswebsite.com'
    
    def contact_email(name, email, body)
       @name = name
       @email = email
       @body = body
       
       mail(from: email, subject: 'You have a new message')
    end
end