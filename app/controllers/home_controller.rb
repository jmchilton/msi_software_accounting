
class HomeController < ApplicationController

  def index

  end

  def flot_test
    dataset1 = [[1.day.ago, 1], [2.day.ago, 2], [3.day.ago, 3],
                     [4.day.ago, 1], [5.day.ago, 2], [6.day.ago, 3],
                     [7.day.ago, 1], [8.day.ago, 2], [9.day.ago, 3],
                     [11.day.ago, 1], [12.day.ago, 2], [13.day.ago, 3],
                     [14.day.ago, 1], [15.day.ago, 2], [16.day.ago, 3],
                     [17.day.ago, 1], [18.day.ago, 2], [19.day.ago, 3],
                     [21.day.ago, 1], [22.day.ago, 2], [23.day.ago, 3],
                     [24.day.ago, 1], [25.day.ago, 2], [26.day.ago, 3],
                     [27.day.ago, 1], [28.day.ago, 2], [29.day.ago, 3],
                     [31.day.ago, 1], [32.day.ago, 2], [33.day.ago, 3],
                     [34.day.ago, 1], [35.day.ago, 2], [36.day.ago, 3],
                     [37.day.ago, 1], [38.day.ago, 2], [39.day.ago, 3]

      ]
    dataset2 = dataset1.collect { |x| [x[0], 7] }
    set_line_chart_data([dataset1, dataset2])
  end

end
