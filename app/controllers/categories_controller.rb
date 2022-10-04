class CategoriesController < ApplicationController
    def index
        @categories = collection
    end

    def new
        @category = Category.new
    end

    def show
        @category = resource
    end

    def create
        @category = Caregory.new(category_params)
        if @category.save
            redirect_to category_url(@category, notice: "Category was successfully created.")
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
        @category = resource
    end

    def update
        @category = resource
        if @category.update(category_params)
            redirect_to category_url(@category, notice: "Category was successfully updated.")
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy 
        @category = resource
        @category.destroy
            redirect_to categories_path, notice: "Category was successfully updated."
    end
    private

    def collection
        Category.all
    end

    def resource
        collection.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
end