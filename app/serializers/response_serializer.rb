class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :request_id, :user_id, :instrument_id
end
