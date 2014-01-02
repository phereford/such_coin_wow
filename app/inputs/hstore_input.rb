class HstoreInput < SimpleForm::Inputs::StringInput
  def input
    form_html
  end

  private
  def hstore_size
    object.send(attribute_name).size if object.send(attribute_name).present?
  end

  def form_html
    %{
      <table class='table table-striped hstore-container'>
        <tr>
          <th>Name</th>
          <th>Value</th>
          <th></th>
        </tr>
        #{input_forms}
        <tr>
          <td>
            #{add_button_html}
          </td>
        </tr>
      </table>
    }
  end

  def input_forms
    form = ''
    if hstore_size.present? && hstore_size > 0
      object.send(attribute_name).each do |attribute, value|
         form << %{
          <tr>
            <td>
              <input type='text' class='dynamicAttribute' size='20' value="#{attribute}" data-hstore-key="#{attribute}" />
            </td>
            <td>
              <input type='text' class='dynamicAttributeValue' name="#{form_name}" id="#{form_id}" size='20' value="#{value}" />
            </td>
            #{remove_button_html}
          </tr>
        }
      end
    end
    return form
  end

  def new_input_html
    %{
      <tr>
        <td>
          <input type='text' class='dynamicAttribute' placeholder='New Attribute' />
        </td>
        <td>
          <input type='text' class='dynamicAttributeValue' name='#{form_name}' placeholder='Value for new attribute'/>
        </td>
        #{remove_button_html}
      </tr>
    }
  end

  def remove_button_html
    %{
      <td>
        <a class='btn btn-warn remove-attribute' href='#'>X</a>
      </td>
    }
  end
  def singularize_attribute_name
    attribute_name.to_s.singularize.capitalize
  end

  def add_button_html
    %{
      <a class='btn add-attribute' href='#' data-insertion-form="#{new_input_html}">Add another #{singularize_attribute_name}</a>
    }
  end

  def object_name_underscored
    object_name.gsub('[', '_').gsub(']', '')
  end

  def form_name
    "#{object_name}[#{attribute_name}]"
  end

  def form_id
    "#{object_name_underscored}_#{attribute_name}"
  end
end
