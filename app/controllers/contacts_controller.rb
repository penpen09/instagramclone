class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to contacts_path, notice: 'Contact was successfully creates.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        # format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        # format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private
  def set_contact
    @contact = Contact.find(params[:id])
  end
  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
