class Dispatch < ApplicationRecord
    self.primary_key = :uuid

    def execute
        self.update executed: true
    end

    def error_happened
        self.update error: true
    end
end
