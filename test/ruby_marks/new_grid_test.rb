require "test_helper"

class RubyMarks::NewTestGrid < Test::Unit::TestCase
  
  def setup
    @prova = 'assets/demo3.png'
    @recognizer = RubyMarks::Recognizer.new
    @recognizer.configure do |config|
      config.edge_level = 6
      config.default_expected_lines = 20
      config.intensity_percentual = 50
      config.default_mark_height = 20
      config.default_mark_width = 20
      config.default_block_width_tolerance = 10    
      config.scan_timeout = 30

      config.define_group :um do |group|
        group.expected_coordinates = {x1: 125, y1: 625, x2: 256, y2: 1140}
        group.expected_lines = 20
      end
      
      config.define_group :dois do |group|
        group.expected_coordinates = {x1: 350, y1: 624, x2: 480, y2: 1140}
        group.expected_lines = 5
      end
    end
    @recognizer.file = @prova
    file = @recognizer.file
    file.write("demo_grid3.png")
  end
  def test_should_return_correct_marks
    expected_hash = { 
      um: {  
        1 => ['B'],
        2 => ['A'],
        3 => ['C'],
        4 => ['C'],
        5 => ['D'],
        6 => ['A'],
        7 => ['D'],
        8 => ['C'],
        9 => ['C'],
        10 => ['E'],
        11 => ['C'],
        12 => ['A'],
        13 => ['B'],
        14 => ['E'],
        15 => ['E'],
        16 => ['B'],
        17 => ['A'],
        18 => ['C'],
        19 => ['B'],
        20 => ['A'],
      },
      dois: {  
        1 => ['A'],
        2 => ['B'],
        3 => ['A'],
        4 => ['E'],
        5 => ['D']
      }
    }
    result = @recognizer.scan
    assert_equal expected_hash, result 
  end
end