module TableHelpers
  def json_response
    ActiveSupport::JSON.decode(response.body)
  end

  def it_should_setup_table_variables
    #assigns(:rows).should respond_to(:each)
    assigns(:fields).should be_an Array
    assigns(:title).should be_a String 
  end

  def it_should_set_rows_to(rows)
    assigns(:rows).should eql(rows)
  end

  def it_should_paginate
    assigns(:allow_pagination).should == true
    assigns(:scroll).should == false
    assigns(:rows_per_page).should == ApplicationController::DEFAULT_NUM_ROWS_PAGINATE
    assigns(:row_list).should == ApplicationController::ROW_LIST_PAGINATE
  end

  def it_should_not_paginate
    assigns(:allow_pagination).should == false
    assigns(:scroll).should == true
    assigns(:rows_per_page).should be > 100
    assigns(:rows_per_page).should == ApplicationController::DEFAULT_NUM_ROWS_NO_PAGINATE
    assigns(:row_list).should == ApplicationController::ROW_LIST_NO_PAGINATE
  end

end
