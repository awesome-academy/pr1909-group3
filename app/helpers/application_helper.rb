module ApplicationHelper
  def redirect_ajax(link)
    render :js => "window.location.replace('#{session[:forwarding_url] || link}')"
  end

  def full_title(page_title = "")
    base_title = "DL-CHAT"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def strftime(datetime)
    datetime.try(:strftime, '%Y/%m/%d %H:%M')
  end
end
