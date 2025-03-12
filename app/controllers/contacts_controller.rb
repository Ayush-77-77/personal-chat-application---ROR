class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts
  end
  def new
    @contact = Contact.new
  end
  def create
    contact = Contact.new(contact_params)
    contact.user = current_user
    if contact.save
      flash[:notice] = "Contact saved"
      redirect_to contacts_path(current_user)
    else
      flash[:alert] = "something went wrong"
      render :new
    end
  end

  private
  def contact_params
    params.expect(contact: [ :name, :phone_number ])
  end
end
