class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.conversation_id = params[:conversation_id]
    @conversation =  Conversation.find_by(id: params[:conversation_id])
    if @message.save
      ChatChannel.broadcast_to(
        @conversation,
        message: render_to_string(partial: "messages/message",
        locals: { message: @message }),
        sender_id: @message.user.id
      )
      redirect_to conversation_path(@conversation) and return
    else
      flash[:alert] = "something went wrong"
      redirect_to conversations_path
    end
  end

  def message_params
    params.expect(message:  :content)
  end
end
