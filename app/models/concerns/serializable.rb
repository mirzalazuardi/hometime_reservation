module Serializable
  extend ActiveSupport::Concern

  included do
    def serializ(params: {})
      ReservationSerializer.new(self, { params: params }).serialized_json
    end
  end
end
