# frozen_string_literal: true

class Admin::ContributionsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_contribution, only: %i[ show edit update destroy validate ]

  def index
    @q = Contribution.includes(:contributable).ransack(params[:q])
    @pagy, @contributions = pagy(@q.result(distinct: true))
    @fields_to_search_in = :name_cont
  end

  def show
    @payable = @contribution
    @payment = Payment.new
    @payments = @contribution.payments
  end

  def new
    @contribution = Contribution.new
  end

  def edit; end

  def create
    @contribution = Contribution.new(contribution_params)

    if @contribution.save
      redirect_back fallback_location: admin_contribution_path(@contribution), notice: "Contribution was successfully created."
    else
      redirect_back fallback_location: "/admin/#{@contribution.contributable_type}/#{@contribution.id}", alert: "#{@contribution.errors.full_messages.to_sentence.capitalize}"
    end
  end

  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to admin_contribution_path(@contribution), notice: "Contribution was successfully updated." }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    redirection_path = @contribution.company ? admin_company_path(@contribution.company_id) : admin_property_path(@contribution.property_id)
    @contribution.cancel!(current_user)

    if @contribution.discard
      redirect_to redirection_path, notice: "Contribution was successfully destroyed."
    end
  end

  def validate
    if @contribution.validate!(current_user)
      redirect_back fallback_location: @contribution, notice: "Contribution validated"
    else
      redirect_back fallback_location: @contribution, alert: "Contribution NOT validated"
    end
  end

  private
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    def contribution_params
      params.require(:contribution).permit(
        :amount,
        :account_id,
        :description,
        :contributable_type,
        :contributable_id,
        :contribution_type,
        :name,
        )
    end
end
