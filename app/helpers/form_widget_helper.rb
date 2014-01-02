module FormWidgetHelper
  def form_html_structure(title, &form)
    %{<div class='form-wrapper'>
        #{form_header(title)}
        #{form_body(&form)}
      </div>}.html_safe
  end

  def form_header(title)
    %{<div class='form-header'>
        <h4 class='lighter'>#{title}</h4>
      </div>}
  end

  def form_body(&form)
    %{<div class='form-body'>
        #{capture(&form)}
      </div>}
  end
end
