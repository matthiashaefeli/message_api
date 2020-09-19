class ProvidersController < ApplicationController
  def index
  end

  def create
    provider = Provider.new(provider_params)
    provider.count = 0
    if provider.valid?
      provider.save
      render json: provider
    else
      render json: { error: provider.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
  end

  private

    def provider_params
      params.require(:provider).permit(:name, :url, :load)
    end
end
