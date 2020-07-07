module ApplicationHelper
  def render_base_modal(patial = "", title = "No", size = "")
    render patial: "shared/modal", locals: { f: f }
  end

  def redirect_ajax(link)
    render :js => "window.location.replace('#{session[:forwarding_url] || link}')"
  end

  def link_to_add_fields(name, f, association, opts = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association,
                          new_object,
                          :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    link_to_function(name,
                     h("add_fields(this,
        \"#{association}\", \"#{escape_javascript(fields)}\");return false;"),
                     class: 'btn btn-success add-task')
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
