class ConversationsController < ApplicationController
  def index
    search_query = params[:query]

    if search_query.present?
      # debugger
      registered_phone_number = current_user.contacts.where(phone_number: User.pluck(:phone_number)).where("name LIKE ?", "%#{search_query}%").pluck(:phone_number)
      registered_user_ids = User.where(phone_number: registered_phone_number).ids
      @conversations = Conversation.where("(sender_id = ? AND receiver_id IN (?)) OR (receiver_id = ? AND sender_id IN (?))",
                                          current_user.id, registered_user_ids, current_user.id, registered_user_ids)
    else
      @conversations = Conversation.where(sender: current_user).or(Conversation.where(receiver: current_user)).includes(:messages)
    end

    @conversation = @conversations.first
    @messages = @conversation ? @conversation.messages : []
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @conversations = Conversation.where(sender: current_user).or(Conversation.where(receiver: current_user))
    render :index
  end
  def create
    receiver = User.find(params[:user_id])
    conversation =  Conversation.find_or_create_by(sender: current_user, receiver: receiver)
    redirect_to conversation
  end
end
