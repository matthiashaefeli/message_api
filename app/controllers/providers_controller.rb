class ProvidersController < ApplicationController
  def index
    providers = Provider.all
    render json: providers
  end

  def create
    provider = Provider.new(provider_params)
    if provider.valid?
      provider.save
      render json: provider
    else
      render json: { error: provider.errors.full_messages }, status: :bad_request
    end
  end

  def update
    provider = Provider.find(params[:provider][:id])
    provider.update_attributes(provider_params)
    render json: provider
  end

  private

    def provider_params
      params.require(:provider).permit(:name, :url, :load, :active)
    end
end
