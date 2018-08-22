require "xmlrpc/server"
require "socket"

s = XMLRPC::Server.new(ARGV[0])
MAX_NUMBER = 16000

class MyAlggago
  def calculate(positions)

    # Write your own codes here
    my_position = positions[0]
    your_position = positions[1]

    current_stone_number = 0
    index = 0
    min_length = MAX_NUMBER
    x_length = MAX_NUMBER
    y_length = MAX_NUMBER
    #내 돌에서 상대거리 hash형태로 넣어둠
    distances = {}
    #여기서 거리 계산하며, 가장 가까운 돌을 치는 코드임. 여기서 차용할 것은 거리계산하는 것.
    # 추가적으로 상대 거리가 가까운 것을 바탕으로 한번에 여러개 보낼 수 있도록. 
    # 358에서 나름 완벽
    if my_position.size == 1 and your_position.size == 2
      your_first = your_position[0]
      your_second = your_position[1]
      my = my_position[0]
      mid_x = (your_second[0] + your_first[0])/2
      mid_y = (your_second[1] + your_first[1])/2
      x_distance = (mid_x - my[0])
      y_distance = (mid_y - my[1])
      current_distance = Math.sqrt(x_distance * x_distance + y_distance * y_distance)
      if current_distance >= 600  
        x_length = (mid_x - my[0]) * 0.5
        y_length = (mid_y - my[1]) * 0.5
      elsif current_distance < 600 and current_distance >= 500 #520에서 짧음
        x_length = (mid_x - my[0]) * 0.55
        y_length = (mid_y - my[1]) * 0.55
      elsif current_distance < 500 and current_distance >= 450
        x_length = (mid_x - my[0]) * 0.6
        y_length = (mid_y - my[1]) * 0.6
      elsif current_distance < 400 and current_distance >= 350 
        x_length = (mid_x - my[0]) * 0.71                       
        y_length = (mid_y - my[1]) * 0.71
      elsif current_distance < 350 and current_distance >= 200 
        x_length = (mid_x - my[0]) * 0.75                      
        y_length = (mid_y - my[1]) * 0.75
      elsif current_distance < 300 and current_distance >= 250  함
        x_length = (mid_x - my[0]) * 0.82                      
        y_length = (mid_y - my[1]) * 0.82
      elsif current_distance < 250 and current_distance >= 200
        x_length = (mid_x - my[0]) * 0.85
        y_length = (mid_y - my[1]) * 0.85
      elsif current_distance < 200 and current_distance >= 150
        x_length = (mid_x - my[0]) * 0.9
        y_length = (mid_X - my[1]) * 0.9
      else
        x_length = (mid_x - my[0])
        y_length = (mid_y - my[1]) 
      end
      current_stone_number = index
      min_length = current_distance
    else 
      my_position.each do |my|
        your_distances = []
        your_position.each do |your|

          x_distance = (my[0] - your[0]).abs
          y_distance = (my[1] - your[1]).abs
          
          current_distance = Math.sqrt(x_distance * x_distance + y_distance * y_distance)
          your_distances.push(current_distance)

          if min_length > current_distance
            current_stone_number = index
            min_length = current_distance
            x_length = (your[0] - my[0]) * 5
            y_length = (your[1] - my[1]) * 5
          end
        end
        distances[index] = your_distances
        index = index + 1
      end
    end
    # End of codes


    # Return values
    message = min_length
    stone_number = current_stone_number
    stone_x_strength = x_length 
    stone_y_strength = y_length

    return [stone_number, stone_x_strength, stone_y_strength, message]

  end

  def get_name
    "MinJung and Trash" # Set your name or team name
  end
  # sk 
  def one_two_cal(positions)
    my_position = positions[0]
    your_position = positions[1]

    return 
  end


  def reduce_speed x, y
    if x*x + y*y > MAX_POWER*MAX_POWER
      co = MAX_POWER / Math.sqrt(x*x + y*y)
      return x*co, y*co
    else
      return x, y
    end
  end
end

s.add_handler("alggago", MyAlggago.new)
s.serve
