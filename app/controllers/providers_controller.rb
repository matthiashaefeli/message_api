# Provider Controller
class ProvidersController < ApplicationController
  def index
    providers = Provider.order(:id)
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: providers
  end

  def create
    provider = Provider.new(provider_params)
    if provider.valid?
      provider.save
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: provider
    else
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: { error: provider.errors.full_messages }, status: :bad_request
    end
  end

  def update
    provider = Provider.find(params[:provider][:id])
    provider.update_attributes(provider_params)
    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: provider
  end

  private

  def provider_params
    params.require(:provider).permit(:name, :url, :load, :active)
  end
end
