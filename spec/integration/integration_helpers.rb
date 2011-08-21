module IntegrationHelpers

  def it_should_have_msi_db_link_for(object)
    page.find_link("msi_db_link")[:href].should == object.msi_db_link
  end

end