class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    @q = current_user.events.ransack(params[:q])
    @events = @q.result
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    result = CreateEvent.call(params: event_params, user: current_user)

    if result.success?
      redirect_to events_path, notice: "Event was successfully created."
    else
      redirect_to new_event_path, notice: result.notice
    end
  end

  def update
    if @event.update(event_params)
      render :show, status: :ok, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path, notice: "Category was successfully destroyed."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :date, :description, :category_id)
  end
end
