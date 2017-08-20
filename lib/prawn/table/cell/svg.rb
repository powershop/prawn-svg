if defined?(Prawn::Table::Cell)
  module Prawn
    class Table
      class Cell
        # A Cell that contains an SVG image
        class SVG < Cell
          # The valid options for an SVG cell
          VALID_OPTIONS = [:svg_data, :svg_height, :svg_width]

          # Creates a new SVG cell.
          def initialize(pdf, point, options = {}, &block)
            Prawn.verify_options(VALID_OPTIONS, options)

            super(pdf, point, options)

            @svg = Prawn::SVG::Interface.new(@svg_data, pdf, { width: @requested_width, height: @requested_height })

            if block
              block.arity < 1 ? instance_eval(&block) : block[self]
            end
          end

          # Draws cell content within the cell's bounding box.
          def draw_content
            @svg.draw
          end

          # Returns the width this cell would naturally take on, absent other
          # constraints.
          def natural_content_width
            @svg.document.sizing.output_width
          end

          # Returns the height this cell would naturally take on, absent
          # constraints.
          def natural_content_height
            @svg.document.sizing.output_height
          end

          def svg_height=(h)
            @requested_height = h
          end

          def svg_width=(w)
            @requested_width = w
          end

          def svg_data=(svg_data)
            @svg_data = svg_data
          end
        end
      end
    end
  end
end
