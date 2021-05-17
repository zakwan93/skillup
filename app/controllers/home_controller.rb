class HomeController < ApplicationController
    
    def index
        @courses = Course.all.limit(3)
        @latest_couses = Course.all.limit(3).order(created_at: :desc)
    end
    
    def activity
        @activities = PublicActivity::Activity.all
    end

end