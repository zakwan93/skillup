class Course < ApplicationRecord
    validates_presence_of :title, :description
    has_rich_text :description
end
