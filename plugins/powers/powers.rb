$:.unshift File.dirname(__FILE__)

module AresMUSH
    module Powers
        
        def self.plugin_dir
            File.dirname(__FILE__)
        end
 
        def self.shortcuts
            Global.read_config("powers", "shortcuts")
        end
 
        def self.get_cmd_handler(client, cmd, enactor)
            case cmd.root
            when "powers"
                case cmd.switch
                when "set"
                return SetPowersCmd
                when "rem"
                return RemovePowersCmd
                else
                return PowersCmd
                end
            end
            nil
        end

    end
end