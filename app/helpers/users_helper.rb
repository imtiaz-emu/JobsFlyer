module UsersHelper
  # devise helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    User
  end

  def devise_error_messages
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="col-lg-12 flash-message-div">
      <div class="alert alert-danger alert-dismissible" role="alert">
        <a href="#" class="close" data-dismiss="alert">&times;</a>
        <ul style="list-style: none">#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end

  def flash_message
    html = '<div class="col-lg-12 flash-message-div">'

    flash.each do |key, message|
      if %w'error alert'.include?(key)
        html += <<-HTML
          <div class="alert alert-danger alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      elsif %w'alert_not_close'.include?(key)
        html += <<-HTML
          <div class="alert-not-close alert-danger alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      else
        html += <<-HTML
          <div class="alert alert-success alert-dismissible" role="alert">
            <a href="#" class="close" data-dismiss="alert">&times;</a>
            #{message}
          </div>
        HTML
      end
    end

    (html + '</div>').html_safe
  end
end
