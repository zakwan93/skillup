class Course < ApplicationRecord
    validates_presence_of :title, :description

    has_rich_text :description

    belongs_to :user

    extend FriendlyId
    # friendly_id :title, use: :slugged

    friendly_id :generated_slug, use: :slugged
    def generated_slug
        require 'securerandom'
        @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
    end
end
