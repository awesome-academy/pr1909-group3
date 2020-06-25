module ApplicationHelper
  def render_base_modal(patial = "", title = "No", size = "")
    render patial: "shared/modal", locals: { f: f }
  end

  def redirect_ajax(link)
    render :js => "window.location.replace('#{session[:forwarding_url] || link}')"
  end

  def link_to_function(name, js, opts = {})
    link_to name, '#', opts.merge({ onclick: js })
  end

  def full_title(page_title = "")
    base_title = "DL-Chat"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def javascript(*files)
    content_for(:specific_js_load) { javascript_include_tag(*files) }
  end

  def strftime(datetime)
    datetime.try(:strftime, '%Y/%m/%d %H:%M')
  end
end
