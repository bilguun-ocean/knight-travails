class Knight
  def initialize
    @visited = Array.new(6) {Array.new(6) {0}}
    @distance = Array.new(6) {Array.new(6) {0}}
    @dx = [-2, -1, 1, 2, 2, 1, -1, -2]
    @dy = [1, 2, 2, 1, -1, -2, -2, -1]
  end

  def minimum_steps_to_reach_target(k_pos, t_pos, queue = [])
    queue.push(k_pos) # Note that k_pos is an array like [3,4] == [x,y]
    set_as_visited(queue[0])  # Accessing @visited as [3][4] per se

    until queue.empty?
      curr = queue.shift

      for i in 0..7 # For every possible moves
        pos_move = [curr[0] + @dx[i], curr[1] + @dy[i]]
        # check if the 'i'th move is valid from current position
        if valid?(pos_move)
          queue.push(pos_move)
          set_as_visited(pos_move)
          set_distance(pos_move, curr)
          # return if target position is reached
          return p @distance[t_pos[0]][t_pos[1]] if reached_target?(t_pos)
        end
      end
    end
    p @visited
    p @distance
  end
  
  def set_as_visited(pos)
    @visited[pos[0]][pos[1]] = 1
  end

  def set_distance(child, current)
    @distance[child[0]][child[1]] = @distance[current[0]][current[1]] + 1
  end

  def reached_target?(t_pos)
    return true if @visited[t_pos[0]][t_pos[1]] == 1
    false
  end

  def valid?(arr)
    # both x and y should be between 0 and 8; arr[0] - x arr[1] - y
    # in this case tho 0, and 5
    return false unless arr[0].between?(0, 5) and arr[1].between?(0, 5)
    # the given position should be not visited before
    return false if @visited[arr[0]][arr[1]] == 1

    # if all is ok return:
    true
  end
end

game = Knight.new
game.minimum_steps_to_reach_target([2,3],[5,0])