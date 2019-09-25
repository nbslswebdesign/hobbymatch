class ContactsController < ApplicationController

    # GET request to /contact-us
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    #POST request to /contacts
        def create
        # Mass assignment of form fields into Contact objects
       @contact = Contact.new(contact_params)
       if @contact.save 
           # Store form fields via parameters , in to variables
           name = params[:contact][:name]
           email = params[:contact][:email]
           body = params[:contact][:comments]
           # Plug variables in to the ContactMailer email method and send email
           ContactMailer.contact_email(name, email, body).deliver
           # Store success message in flash hash and redirect to new action
           flash[:success] = "We got your message, thank you"
           redirect_to new_contact_path
       else 
           # If object doesnt save store errors in flash hash and redirect to new action
           flash[:danger] = @contact.errors.full_messages.join(", ")
           redirect_to new_contact_path
       end
        end
    
    private
    # To collect data from form, we need to use strong parameters and whitelist form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
    
end