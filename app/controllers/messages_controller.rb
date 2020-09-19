# Message Controller
class MessagesController < ApplicationController
  def index
    messages =
      if params[:to_number]
        Message.where(to_number: params[:to_number])
      elsif params[:provider_id]
        Message.where(provider_id: params[:provider_id])
      else
        Message.all
      end
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: messages
  end

  def create
    message = Message.new(message: params[:message], to_number: params[:to_number])
    if message.valid?
      message.save
      MessageCreator.new(message).send_message
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: message
    else
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: { error: message.errors.full_messages }, status: :bad_request
    end
  end

  def update
    message = Message.find_by(message_id: params[:message_id])
    message.status = params[:status]
    message.save
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: message
  end
end
