module Shortest
  module Path
    class PriorityQueue
      def initialize; @list = [] end

      def add(priority, item)
        @list << [priority, @list.length, item]
        @list.sort!
        self
      end

      def <<(pritem); add(*pritem) end
      def next; @list.shift[2] end
      def empty?; @list.empty? end
    end

    class AStar
      def initialize(dist, cost, graph, start, goal)
        @graph = graph
        @dist  = dist ; @cost = cost
        @start = start ; @goal=goal
      end

      def search
        been_there = {}
        pqueue = Shortest::Path::PriorityQueue.new
        pqueue << [1, [@start, [], 0]]
        while !pqueue.empty?
          spot, path_so_far, cost_so_far = pqueue.next
          next if been_there[spot]
          newpath = path_so_far + [spot]
          return newpath if (spot == @goal)
          been_there[spot] = 1
          @graph.neighbors(spot).each do |newspot|
            next if been_there[newspot]
            tcost = @cost.call(spot, newspot)
            next unless tcost
            newcost = cost_so_far + tcost
            pqueue << [newcost + @dist.call(@goal, newspot), [newspot, newpath, newcost]]
          end
        end
        return []
      end
    end

    # `dist` function which calculates distance between two points
    # `heur` heuristic function
    # `graph` graph structure
    # `start` start node
    # `goal` goal node
    def astar(dist, heur, graph, start, goal); Shortest::Path::AStar.new(dist, heur, graph, start, goal).search end

    module_function :astar
  end
end
