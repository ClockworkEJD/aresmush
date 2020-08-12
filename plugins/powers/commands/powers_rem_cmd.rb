module AresMUSH
    module Powers
        class RemovePowersCmd
            include CommandHandler
                  
            attr_accessor :name, :power_name
              
            def parse_args
                if (cmd.args =~ /.+=.+/)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            
                    self.name = titlecase_arg(args.arg1)
                    self.power_name = titlecase_arg(args.arg2)
                else
                    self.name = enactor_name
                    self.power_name = titlecase_arg(cmd.args)
                end
            end
        
            def required_args
                [ self.name, self.power_name ]
            end
        
            def handle
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        powers = model.powers || {}
                        powers.delete self.power_name
                        model.update(powers: powers)
                        client.emit_success t('powers.power_removed')
                    elsif Chargen.can_approve?(enactor)
                        powers = model.powers || {}
                        powers.delete self.power_name
                        model.update(powers: powers)
                        client.emit_success t('powers.power_removed')                   
                    else
                    client.emit_failure t('dispatcher.not_allowed')
                    end
               end
          end
        end
    end
end