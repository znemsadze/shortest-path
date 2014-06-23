require 'algorithms'

module Shortest
  module Path
    class AStar
      def initialize(dist,heur,graph,start,goal)
        @dist=dist ; @heur=heur ; @graph=graph
        @start=start ; @goal=goal
      end

      def search
        closedset=[] ; openset=Containers::PriorityQueue.new ; came_from={}
        start_g_score=0 ; start_f_score=start_g_score+@heur.call(@start,@goal)
        g_score={@start => start_g_score} ; f_score={@start => start_f_score}
        openset.push(@start, start_f_score)

# debugger

        until openset.empty?
          current=openset.pop
          return reconstruct_path(came_from,goal) if current==@goal
          closedset<<current
          @graph.neighbors(current).each do |neighbor|
            next if closedset.include?(neighbor)
            tentative_g_score=g_score[current]+@dist.call(current,neighbor)

            openset.include?(neighbor)

            # if (not openset.include?(neighbor)) or (tentative_g_score < (g_score[neighbor]||Float::INFINITY))
            #   came_from[neighbor]=current
            #   g_score[neighbor]=tentative_g_score
            #   f_score[neighbor]=tentative_g_score+@heur.call(neighbor,@goal)
            #   if not openset.include?(neighbor)
            #     openset << neighbor
            #   end
            # end
          end
        end
        return [] # failure!
      end

      private

      def reconstruct_path(came_from, current_node)
        if came_from.include?(current_node)
          came_from << current_node
          came_from
        else
          [current_node]
        end
      end
    end

    # `dist` function which calculates distance between two points
    # `heur` heuristic function
    # `graph` graph structure
    # `start` start node
    # `goal` goal node
    def astar(dist,heur,graph,start,goal)
      Shortest::Path::AStar.new(dist,heur,graph,start,goal).search
    end

    module_function :astar
  end
end
