module Shortest
  module Path
    class PriorityQueueItem
      attr_reader :item, :priority

      def initialize(item,priority)
        @item = item ; @priority = priority
      end
    end

    class PriorityQueue
      def initialize; @heap = [] end

      def add_with_priority(object, priority)
        item = PriorityQueueItem.new(object,priority)
        @heap << item
        sort_by_priority
      end

      def change_priority(object, priority)
        @heap.select{|x| x.item==object}.first.priority=priority
        sort_by_priority
      end

      def pop; @heap.delete_at(0).item end
      def empty?; @heap.empty? end
      def include?(object); @heap.select{|x| x.item==object}.any? end

      private
      def sort_by_priority; @heap.sort!{ |x,y| x.priority <=> y.priority } end
    end
  end
end
