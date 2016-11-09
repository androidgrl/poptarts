class PoptartsController < ApplicationController
  respond_to :json

  def index
    poptarts = Poptart.all

    if params[:promotion] == 'halloween'
      respond_with poptarts, serializer: HalloweenPoptartSerializer
    else
      respond_with poptarts
    end
  end

  def show
    poptart = Poptart.find_by(id: params[:id])

    if params[:promotion] == 'halloween'
      respond_with poptart, serializer: HalloweenPoptartSerializer
    else
      respond_with poptart
    end
  end

  def create
    poptart = Poptart.create(poptart_params)
    respond_with poptart
  end

  def update
    poptart = Poptart.find(params[:id])
    respond_with poptart.update(poptart_params)
  end

  def destroy
    poptart = Poptart.find(params[:id])
    poptart.destroy
    respond_with poptart
  end

  private

  def poptart_params
    params.require(:poptart).permit(:flavor, :sprinkles)
  end
end
