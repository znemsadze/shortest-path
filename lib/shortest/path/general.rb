module Shortest
  module Path
    class Edge
      attr_accessor :src, :dst, :length

      def initialize(src, dst, length)
        @src=src
        @dst=dst
        @length=length
      end
    end

    class Graph #< Array
      attr_accessor :edges

      def initialize
        @edges={}
      end

      def connect(src, dst, length)
        # raise "No such vertex: #{src}" unless self.include?(src)
        # raise "No such vertex: #{dst}" unless self.include?(dst)

        if (@edges.has_key?(src))
          @edges[src][dst]=length
        else
          @edges[src]={dst => length}
        end

        # @edges.push Edge.new(src, dst, length)
      end

      def connect_mutually(vertex1, vertex2, length, directed)
        self.connect(vertex1, vertex2, length)
        if (directed!=1)
          self.connect(vertex2, vertex1, length)
        end
      end


      def remove_edge(vertex1, vertex2)
        if (@edges[vertex1]!=nil)
          @edges[vertex1]=@edges[vertex1].except(:vertex2);
        end

        if (@edges[vertex2]!=nil)
          @edges[vertex2]=@edges[vertex2].except(:vertex1);
        end
        # for_remove = @edges.select{ |e| (e.src == vertex1 && e.dst == vertex2) || (e.src == vertex2 && e.dst == vertex1) }
        #
        # for_remove.each do |edge|
        #   @edges.delete_at(@edges.index(edge))
        # end
      end

      def neighbors(vertex)
        # neighbors = []
        # @edges.each{|edge| neighbors.push edge.dst if edge.src==vertex }
        @edges[vertex]

        # neighbors.uniq
      end
    end
  end
end