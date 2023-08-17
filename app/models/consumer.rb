class Consumer < ApplicationRecord
    self.primary_key = :uuid

    before_validation do 
        self.uuid ||= SecureRandom.uuid
    end
end
