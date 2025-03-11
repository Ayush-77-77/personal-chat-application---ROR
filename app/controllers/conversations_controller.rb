class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where(sender: current_user).or(Conversation.where(receiver: current_user)).includes(:messages)
    @conversation = @conversations.first
    @messages = @conversation ? @conversation.messages : []
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @conversations = Conversation.where(sender: current_user).or(Conversation.where(receiver: current_user))
    render :index
  end
end
