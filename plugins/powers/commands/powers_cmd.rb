module AresMUSH
    module Powers
        class PowersCmd
            include CommandHandler

            attr_accessor :name

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = PowersTemplate.new(model, model.powers || {})
                    client.emit template.render
                end
            end
        end
    end
end