class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :show, :destroy]
    before_action :require_user
    before_action :require_admin

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Category was created successfully."
            redirect_to categories_path
        else
            render 'new'
        end
    end

    def edit

    end

    def show
        #@category = Category.find(params[:id])
    end

    def destroy

    end

    private
    def category_params
        params.require(:category).permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
    end

    def require_admin
        if !current_user.admin?
            flash[:danger] = "Premission denied."
            redirect_to root_path
        end
    end
end