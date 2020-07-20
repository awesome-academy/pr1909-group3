# frozen_string_literal: true

class Dashboard::DocumentsController < Dashboard::DashboardController
  before_action :load_event
  before_action :load_document, except: %i[new index create]
  def index
    @documents = @event.documents.order(created_at: :desc)
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @document = Document.new
    gon.push(event: @event)
  end

  def edit; end

  def create
    @document = @event.documents.build(document_params)
    if @document.save
      @document.message_to_stream('create', 'all')
    else
    end
  end

  def update
    if @document.update_attributes document_params
      @document.message_to_stream('update_content', 'all')
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @document.destroy
      @document.message_to_stream('delete', 'all')
    end
  end

  def change_status
    return unless @document.changeStatus
    action = @document.active ? 'enable_time_line' : 'disable_time_line'
    @document.message_to_stream(action, 'all')
  end

  private

  def load_document
    @document = Document.find_by id: params[:id]
    return if @document
    flash[:danger] = t '.danger'
    redirect_to admin_events_path
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t '.danger'
    redirect_to dashboard_events_path
  end

  def document_params
    params.require(:document).permit :file, :event_id, :title
  end
end
