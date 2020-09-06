$:.unshift File.dirname(__FILE__)

module AresMUSH
    module ESHTraits

        def self.plugin_dir
            File.dirname(__FILE__)
        end

        def self.shortcuts
            Global.read_config("eshtraits", "shortcuts")
        end

        def self.get_cmd_handler(client, cmd, enactor)
            case cmd.root
            when "powers"
                case cmd.switch
                when "set"
                    return SetPowersCmd
                when "clear"
                    return ClearPowersCmd
                else 
                    return PowersCmd
                end
            when "skills"
                case cmd.switch
                when "set"
                    return SetSkillsCmd
                when "clear"
                    return ClearSkillsCmd
                else 
                    return SkillsCmd
                end
            when "advantages"
                case cmd.switch
                when "set"
                    return SetAdvantagesCmd
                when "clear"
                    return ClearAdvantagesCmd
                else
                    return AdvantagesCmd
                end
            when "flaws"
                case cmd.switch
                when "set"
                    return SetFlawsCmd
                when "clear"
                    return ClearFlawsCmd
                else 
                    return FlawsCmd
                end
            when "sheet"
                return SheetCmd
            end
        end

        nil
    end
end