class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      flash[:message] = "Thank you for contacting us! We will get back with you ASAP."
      redirect_to root_path
    else
      render :new
    end
  end

end
