class MessagesController < ApplicationController
  def index
  end

  def create
    message = Message.new(message: params[:message], to_number: params[:to_number])
    if message.valid?
      message.save
      MessageCreator.new(message).send_message
      render json: message
    else
      render json: { error: message.errors.full_messages }, status: :bad_request
    end
  end

  def update
    message = Message.find_by(message_id: params[:message_id])
    message.status = params[:status]
    message.save
  end
end
