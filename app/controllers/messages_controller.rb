class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.conversation_id = params[:conversation_id]
    if @message.save
      redirect_to conversation_path(@message.conversation_id)
    else
      flash[:alert] = "something went wrong"
      redirect_to "conversations_path"
    end
  end

  def message_params
    params.expect(message:  :content)
  end
end
