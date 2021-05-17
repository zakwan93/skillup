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

    LANGUAGES = [:'English', :"Spanish", :"Hindi"]
    def self.languages
        LANGUAGES.map {|language| [language, language]}
    end

    LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
    def self.levels
        LEVELS.map { |level| [level, level] }
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user }
end
