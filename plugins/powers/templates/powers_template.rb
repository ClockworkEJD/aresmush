module AresMUSH
    module Powers
        class PowersTemplate < ErbTemplateRenderer

            attr_accessor :char, :Powers

            def initialize(char, powers)
                @char = char
                @powers = powers
                super File.dirname(__FILE__) + "/powers.erb"
            end 
        end
    end
end 