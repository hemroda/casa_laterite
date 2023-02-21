# frozen_string_literal: true

module Admin
  class TodoItemsController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_todo_item, only: %i[show edit update destroy reactivate complete]

    def index
      @todo_items = TodoItem.all
    end

    def show; end

    def new
      @todo_item = TodoItem.new
    end

    def edit; end

    def create
      @todo_item = TodoItem.new(todo_item_params)
      if @todo_item.save
        redirect_to admin_todo_items_path(@todo_item), notice: "Todo item was created!"
      else
        redirect_to admin_todo_items_path(@todo_item), alert: "Todo item was not created!"
      end
    end

    def update
      if @todo_item.update(todo_item_params)
        redirect_back fallback_location: admin_todo_items_path, notice: "The todo_item has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @todo_item.destroy
        redirect_back fallback_location: admin_todo_items_path, notice: "The todo_item has been deleted."
      else
        redirect_back fallback_location: admin_todo_items_path, notice: "The todo_item has NOT been deleted."
      end
    end

    def complete
      @todo_item.completed!

      if @todo_item.completed?
        redirect_back fallback_location: admin_todo_items_path, notice: "Todo item was set to completed!"
      else
        redirect_back fallback_location: admin_todo_items_path, alert: "Todo item was not set to completed!"
      end
    end

    def reactivate
      if @todo_item.reactivate!
        redirect_back fallback_location: admin_todo_items_path, notice: "Todo item was reactivated!"
      else
        redirect_back fallback_location: admin_todo_items_path, alert: "Todo item was not reactivated!"
      end
    end

    private
      def set_todo_item
        @todo_item = TodoItem.find(params[:id])
      end

      def todo_item_params
        params.require(:todo_item).permit(:id,
                                          :completed,
                                          :completed_date,
                                          :title,
                                          :task_id)
      end
  end
end
