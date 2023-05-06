module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :unique_id

    def connect
      self.unique_id = SecureRandom.base58 64
    end
  end
end
