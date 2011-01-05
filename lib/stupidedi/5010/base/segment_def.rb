module Stupidedi
  module FiftyTen
    module Base

      class SegmentDef
        attr_reader \
          :id,
          :name,
          :element_uses

        def initialize(id, name, *element_uses)
          @id, @name, @element_uses = id, name, element_uses

          unless @element_uses.all?{|e| e.is_a?(ElementUse) }
            raise TypeError, "Each element use must be a kind of ElementUse"
          end
        end

        def tail
          self.class.new(@id, @name, *@element_uses.tail)
        end

        def empty
          Values::SegmentVal.empty(self)
        end

        def writer(interchange_header)
          # TODO
        end

        def reader(input, interchange_header)
          SegmentReader.new(input, interchange_header, self)
        end

        def segment_use(offset, requirement_designator, repetition_count)
          SegmentUse.new(offset, self, requirement_designator, repetition_count)
        end
      end

    end
  end
end