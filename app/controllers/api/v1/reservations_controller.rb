class Api::V1::ReservationsController < ApplicationController
  before_action only: [:create, :update] do
    translate_params(action_name.to_sym)
  end
  before_action only: [:show, :update, :destroy] do
    find_reservation(action_name.to_sym)
  end
  respond_to :json

  def index
    @reservations = Reservation.all

    respond_with @reservations
  end

  def show
    respond_with @reservation.serializ
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      respond_with @reservation.serializ,
        location: -> {  api_v1_reservation_path(id: @reservation.id) }
    else
      respond_with @reservation
    end

  end

  def update
    raise ActiveRecord::RecordNotFound unless @reservation

    overide_modified_params
    if @reservation.update(reservation_params(__method__))
      respond_with @reservation.serializ
    else
      respond_with @reservation.errors
    end
  end

  def destroy
    @reservation.destroy

    respond_with @reservation
  end

  private
    def find_reservation(type = :show)
      return @reservation = Reservation.find(params[:id]) if type == :show

      @reservation = Reservation.find_by(code: @modified_params[:reservation][:code])
    end

    def overide_modified_params
      @modified_params = {
        reservation: except_nested_key(@modified_params[:reservation].as_json, ['email']).except('guest_attributes')
      }
    end

    def reservation_params(type = :create)
      @modified_params = create_params(@modified_params) if @modified_params.class == Hash
      @modified_params.require(:reservation)
        .permit(:code, :guest_id, :start_date, :end_date, :currency,
                :adults_amount, :children_amount, :infants_amount,
                :nights_quota, :payout_price, :security_price,
                :total_price, :status, **guest_attributes(type))
    end

    def guest_attributes(type = :create)
      if type == :create
        {guest_attributes: [ :id, :email, :first_name, :last_name, guest_phones_attributes: [:id, :number] ]}
      else
        {}
      end
    end

    def translate_params(type = :create)
      translator = Reservation.translator_klass(params)
      attrs = { reservation: translator.new(params).call }

      @modified_params = create_params(attrs)
    end
end
