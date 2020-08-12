module AresMUSH
    module Powers
        class SetPowersCmd
            include CommandHandler
                  
            attr_accessor :name, :power_name, :description
              
            def parse_args
                if (Chargen.can_approve?(enactor) && cmd.args =~ /\//)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            
                    self.name = titlecase_arg(args.arg1)
                    self.power_name = titlecase_arg(args.arg2)
                    self.description = args.arg3
                else
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            
                    self.name = enactor_name
                    self.power_name = titlecase_arg(args.arg1)
                    self.description = args.arg2
                end
            end
        
            def required_args
                [ self.name, self.power_name, self.description ]
            end
        
            def handle
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name || Chargen.can_approve?(enactor))
                        powers = model.powers || {}
                        powers[self.powre_name] = self.description
                        model.update(powers: powers)
                        client.emit_success t('powers.power_set')
                    else
                    client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end