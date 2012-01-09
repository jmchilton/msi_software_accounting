

module PageHelpers

  def it_should_have_model_field(field, title, value)
    page.find("div#model_field_#{field} > div.model_field_label").should have_content(title)
    page.find("div#model_field_#{field} > div.model_field_value").should have_content(value)
  end

  def it_should_have_model_link(title, to)
    page.find(:xpath, "//a[@href='#{to}' and @class='model_link']").should have_content(title)
  end

  def it_should_have_title_text(text)
    page.find("h1").text.should eql(text)
  end

  def it_should_render_date_options
    page.find("input[name=from]").should_not be_nil
    page.find("input[name=to]").should_not be_nil
  end

  def it_should_render_report_options(optional_args = {})
    it_should_render_date_options
    optional_args.reverse_merge!({:exclude_employees => true, :limit_users => false})
    should_find(optional_args[:exclude_employees], "input[name=exclude_employees]")
    should_find(optional_args[:limit_users], "textarea[name=limit_users]")
  end

  def should_find(whether_should_find, css_selector)
    if whether_should_find
      page.find(css_selector).should_not be_nil
    else
      lambda { page.find(css_selector) }.should raise_error
    end

  end

end