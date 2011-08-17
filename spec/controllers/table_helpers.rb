module TableHelpers

  def it_should_setup_table_variables
    #assigns(:rows).should respond_to(:each)
    assigns(:fields).should be_an Array
    assigns(:title).should be_a String 
  end

  def it_should_set_rows_to(rows)
    assigns(:rows).should eql(rows)
  end

end
