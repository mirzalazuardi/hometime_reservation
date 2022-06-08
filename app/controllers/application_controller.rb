class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  def except_nested_key(hash_obj, keys)
     Hash[hash_obj.map {|k,v| [k,(v.respond_to?(:except)?v.except(*keys):v)] }]
  end

  def create_params(hash_obj)
    ActionController::Parameters.new(hash_obj)
  end
end
