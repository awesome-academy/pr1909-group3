# frozen_string_literal: true

module TimeLineUpdate
  extend ActiveSupport::Concern
  include ActionView::Helpers::JavaScriptHelper

  ACTIONS = {
    create: 'create',
    update_content: 'update_content',
    enable_time_line: 'enable_time_line',
    disable_time_line: 'disable_time_line',
    delete: 'delete',
  }.freeze

  included do
    scope :actived, -> { where active: true }
  end

  def info_to_channel(action_type, display)
    {
      action: action_type,
      type: self.class.name.downcase,
      timeline_html: timeline_data_render(display),
      tab_html: tab_data_render(display),
      event_id: event_id,
      title: title,
      id: id,
    }
  end

  def tab_data_render(display)
    name = self.class.name.downcase
    ApplicationController.render(
      partial: "#{display == 'admin' ? 'dashboard/' : ''}#{name.pluralize}/#{name}",
      locals: { "#{self.class.name.downcase}": self }
    )
  end

  def timeline_data_render(display)
    return '' if self.class.name.casecmp('document').zero?
    ApplicationController.render(
      partial: "#{display == 'admin' ? 'dashboard/' : ''}timeline/#{self.class.name.downcase}",
      locals: { "#{self.class.name.downcase}": self }
    )
  end

  def message_to_stream(action_type, display)
    data = info_to_channel action_type, display
    if display == 'participant'
      TimelineUpdateJob.perform_later(data)
    elsif display == 'admin'
      DashboardTimelineUpdateJob.perform_later(data)
    else
      TimelineUpdateJob.perform_later(data)
      data = info_to_channel action_type, 'admin'
      DashboardTimelineUpdateJob.perform_later(data)
    end
  end

  def escape_js(text)
    escape_javascript text
  end

  private

  def update_action
    if @active_changed
      active ? 'enable_time_line' : 'disable_time_line'
    else
      'update_content'
    end
  end
end
