class SpicesController < ApplicationController
  wrap_parameters format: []

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


def index
  render json: Spice.all, status: :ok
end

def show
  spice = find_spice
  render json: spice, status: :ok
end

def create
  spice = Spice.create(spice_params)
  render json: spice, status: :ok
end

def update
  spice = find_spice
  spice.update(spice_params)
  render json: spice, status: :accepted
end

def destroy
  find_spice.destroy
  head :no_content
end


private
  def render_not_found_response
    json render: {error: "spice not found"}, status: :not_found
  end

  def find_spice
    Spice.find(params[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end
end
