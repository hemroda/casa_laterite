# frozen_string_literal: true

class Admin::EventsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy discard undiscard]
  before_action :authorized_users,
                only: %i[show edit update destroy discard undiscard]

  def index
    @q = Event.for_user(current_user).ransack(params[:q])
    @pagy, @events = pagy(@q.result(distinct: true))
    @fields_to_search_in = :title_cont
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_back fallback_location: admin_root_path, notice: "Event created!"
    else
      redirect_back fallback_location: admin_root_path,
                    alert: "Event has not been created!"
    end
  end

  def update
    if @event.update(event_params)
      redirect_back fallback_location: admin_root_path, notice: "The event has been updated!"
    else
      redirect_back fallback_location: admin_root_path, alert: "Event has not been updated!"
    end
  end

  def destroy
    if @event.destroy
      redirect_back fallback_location: admin_root_path,
                    notice: "The event has been deleted."
    else
      redirect_back fallback_location: admin_root_path,
                    alert: "The event has NOT been deleted."
    end
  end

  def discard
    @event.discard!
    if @event.discarded?
      redirect_to admin_root_path
    else
      redirect_back fallback_location: admin_root_path,
                    alert: "The event has NOT been discarded."
    end
  end

  def undiscard
    @event.undiscard!
    if @event.undiscarded?
      redirect_to admin_events_path
    else
      redirect_back fallback_location: admin_root_path,
                    alert: "The event has NOT been undiscarded."
    end
  end

  private

  def authorized_users
    unless current_user == @event.user
      redirect_back fallback_location: admin_root_path,
                    alert: "No can do buddy. Not your event!"
    end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title,
      :start_time,
      :end_time,
      :description,
      :location,
      :color,
      :event_type,
      :user_id
    )
  end
end
