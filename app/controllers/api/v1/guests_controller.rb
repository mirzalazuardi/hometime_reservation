class Api::V1::GuestsController < ApplicationController
  before_action :find_guest, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @guests = Guest.all

    respond_with @guests
  end

  def show
    respond_with @guest
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.save

    respond_with @guest
  end

  def update
    @guest.update(guest_params)

    respond_with @guest
  end

  def destroy
    @guest.destroy

    respond_with @guest
  end

  private
    def find_guest
      @guest = Guest.find(params[:id])
    end

    def guest_params
      params.require(:guest)
        .permit(:email, :first_name, :last_name)
    end
end
