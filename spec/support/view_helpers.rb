module ViewHelpers

  def page
    Capybara::Node::Simple.new(rendered)
  end

  def it_should_have_model_field(field, title, value)
    page.find("div#model_field_#{field} > div.model_field_label").should have_content(title)
    page.find("div#model_field_#{field} > div.model_field_value").should have_content(value)
  end

  def it_should_render_report_options
    page.find("input[name=from]").should_not be_nil
    page.find("input[name=to]").should_not be_nil
  end

end