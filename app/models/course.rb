class Course < ApplicationRecord
    validates_presence_of :title, :description, :language, :level, :price

    has_rich_text :description

    belongs_to :user

    extend FriendlyId
    # friendly_id :title, use: :slugged

    friendly_id :generated_slug, use: :slugged
    def generated_slug
        require 'securerandom'
        @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
    end

    after_initialize :set_defaults

    def set_defaults
        self.language ||= "English"
        self.level ||= "Beginner"
        self.price ||= 0
    end

end
