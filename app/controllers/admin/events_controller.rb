class Admin::EventsController < ApplicationController
  layout 'admin'
  
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  #  show,editに書く @event = Event.find(params[:id])と同じ意味。updateは後述s
  
  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end
  
  #newで入力したデータからcreateする関数。eventテーブル（＝モデル）をrequireし、カラムをpermitすることで
  #paramsを持ってくる必要があるが、何行も書くと情緒的になるのでprivateの中に関数としてevent_paramsを作る。
  
  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to admin_event_path(@event), notice: 'Event was successfully created.'
  end
  
  def update
    @event.update(event_params)
    redirect_to admin_event_path(@event), notice: "Event was successfully updated."
  end
  
  def destroy
    @event.destroy
    redirect_to admin_events_url, notice: 'Event was successfully destroyed.'
  end
  
  private
    def set_event
      @event = Event.find(params[:id])
    end

  def event_params
    params.require(:event).permit(:title, :location, :start_at, :ticket_price, :ticket_quantity, :event_category_id)
  end
end
