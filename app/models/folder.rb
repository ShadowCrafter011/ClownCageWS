class Folder < ApplicationRecord
    has_many :actions, dependent: :nullify
    has_many :folders, dependent: :nullify
    belongs_to :folder, optional: true
end
