class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]

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

    def update
        if @category.update(category_params)
            flash[:success] = "Category name updated successfully."
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end

    def show
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end

    def destroy
        @category.destroy

        flash[:danger] = "Category was successfully deleted."
        redirect_to categories_path
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