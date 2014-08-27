module AresMUSH
  class AnsiFormatter    
    def self.ansi_code_map
      {
        "x" => ANSI.black,
        "r" => ANSI.red,
        "g" => ANSI.green,
        "y" => ANSI.yellow,
        "b" => ANSI.blue,
        "m" => ANSI.magenta,
        "c" => ANSI.cyan,
        "w" => ANSI.white,

        "X" => ANSI.on_black,
        "R" => ANSI.on_red,
        "G" => ANSI.on_green,
        "Y" => ANSI.on_yellow,
        "B" => ANSI.on_blue,
        "M" => ANSI.on_magenta,
        "C" => ANSI.on_cyan,
        "W" => ANSI.on_white,

        "u" => ANSI.underline,
        "h" => ANSI.bold,
        "i" => ANSI.inverse,

        "U" => ANSI.underline_off,
        "I" => ANSI.inverse_off,
        "H" => ANSI.bold_off,

        "n" => ANSI.reset

        # No, I did not forget 'blink'.  Blink is evil. :)
      }
    end
    
    def self.format(str)
      return nil if str.nil?
      return str if str !~ code_regex
      formatted_str = ""
      groups = ansi_groups(str)
      groups.each do |g|
        if (g.start_with?("%x") || g.start_with?("%c"))
          code = g.gsub(/%[xXcC]/, "")
          formatted_str << ansi_code_map[code]
        else
          formatted_str << g
        end
      end
      formatted_str
    end

    def self.truncate(str, width)
      groups = ansi_groups(str)
      return str.truncate(width) if str !~ code_regex
      keep = keep_groups_up_to_width(groups, width)
      keep[:groups].join
    end
        
    def self.center(str, width, pad_char = " ")
      return nil if str.nil?
      return str.truncate(width).center(width, pad_char) if str !~ code_regex
      groups = ansi_groups(str)
      keep = keep_groups_up_to_width(groups, width)
      length = keep[:length]
      fake_str = length.times.collect { "`" }.join
      formatted_str = fake_str.center(width, pad_char)
      formatted_str.gsub(fake_str, keep[:groups].join)
    end
    
    def self.left(str, width, pad_char = " ")
      return nil if str.nil?
      return str.truncate(width).ljust(width, pad_char) if str !~ code_regex
      groups = ansi_groups(str)
      keep = keep_groups_up_to_width(groups, width)
      length = keep[:length]
      fake_str = length.times.collect { "`" }.join
      formatted_str = fake_str.ljust(width, pad_char)
      
      formatted_str.gsub(fake_str, keep[:groups].join)
    end
    
    def self.right(str, width, pad_char = " ")
      return nil if str.nil?
      return str.truncate(width).rjust(width, pad_char) if str !~ code_regex
      groups = ansi_groups(str)
      keep = keep_groups_up_to_width(groups, width)
      length = keep[:length]
      fake_str = length.times.collect { "`" }.join
      formatted_str = fake_str.rjust(width, pad_char)
      formatted_str.gsub(fake_str, keep[:groups].join)
    end
    
    def self.strip_ansi(str)
      str.gsub(code_regex, "")
    end
    
    private
    
    def self.ansi_length(groups)
      groups.select { |g| !g.start_with?("%") }.join.length
    end
    
    def self.keep_groups_up_to_width(groups, width)
      real_length = ansi_length(groups)
      return { :groups => groups, :length => real_length } if real_length <= width

      keep = []
      len = 0
      groups.each do |g|
        if (g.start_with?("%"))
          keep << g
        else
          group_length =  g.length
          if (len + group_length < width)
            keep << g
            len = len + group_length
          else
            keep << g.truncate(width - len)
            keep << "%xn"
            len = width
            break
          end
        end
      end
      { :groups => keep, :length => len }
    end
    
    def self.ansi_groups(str)
      str.split(code_regex)
    end
    
    # Funky regex to look for codes not preceded by a single backlash.
    def self.code_regex
      /((?<!\\)%[xXcC][\w])/
    end
    
  end
end