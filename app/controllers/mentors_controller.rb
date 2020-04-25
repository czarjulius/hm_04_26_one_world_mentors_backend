class MentorsController < ApplicationController

    def mentors
        mentors = User.where(user_type: 'mentor')
        render json:{mentors: mentors}, status: 200
    end
end