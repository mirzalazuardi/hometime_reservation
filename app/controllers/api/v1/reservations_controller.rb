class Api::V1::ReservationsController < ApplicationController
  before_action :find_reservation, only: [:show, :update, :destroy]
  before_action :translate_params, only: [:create, :update]
  respond_to :json

  def index
    @reservations = Reservation.all

    respond_with @reservations
  end

  def show
    respond_with @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.save

    respond_with @reservation, location: -> {  api_v1_reservation_path(id: @reservation.id) }
  end

  def update
    @reservation.update(reservation_params)

    respond_with @reservation
  end

  def destroy
    @reservation.destroy

    respond_with @reservation
  end

  private
    def find_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      @modified_params.require(:reservation)
        .permit(:code, :guest_id, :start_date, :end_date, :currency,
                :adults_amount, :children_amount, :infants_amount,
                :nights_quota, :payout_price, :security_price,
                :total_price, :status,
                guest_attributes: [
                  :id, :email, :first_name, :last_name,
                  guest_phones_attributes: [:id, :number]
                ])
    end

    def translate_params
      @modified_params = ActionController::Parameters
        .new({reservation: translator_klass.new(params).call})
    end

    def translator_klass
      return ::ReservationTranslator::SecondPayload if params.keys.include?('reservation')
      ::ReservationTranslator::FirstPayload
    end
end
