class SearchesController < ApplicationController
    def search
        @task = Task.where("title LIKE ?", "%#{params[:title]}%")
        redirect_to root_path
    end
end
