module AresMUSH
  module Chargen
    def self.custom_app_review(char)
            
      # If you don't want to have any custom app review steps, return nil
      #return nil
            
      # Otherwise, return a message to display.  Here's an example of how to 
      # give an alert if the character has chosen an invalid position for their 
      # faction.
      #
      #  faction = char.group("Faction")
      #  position = char.group("Position")
      #  
      #  if (position == "Knight" && faction != "Noble")
      #    msg = "%xrOnly nobles can be knights.%xn"
      #  else
      #    msg = t('chargen.ok')
      #  end
      #
      #  return Chargen.format_review_status "Checking groups.", msg
      #
      # You can also use other built-in chargen status messages, like t('chargen.not_set').  
      # See https://www.aresmush.com/tutorials/config/chargen.html for details.

      powers = char.powers

      if (powers.length > 0)
        powersmsg = t('chargen.ok')
      else
        powersmsg = t('chargen.oops_missing', :missing => "Powers")
      end

      skills = char.skills

      if (skills.length > 0)
        skillsmsg = t('chargen.ok')
      else
        skillsmsg = t('chargen.oops_missing', :missing => "Skills")
      end

      advantages = char.advantages 

      if (advantages.length > 0)
        advmsg = t('chargen.ok')
      else
        advmsg = t('chargen.oops_missing', :missing => "Advantages")
      end

      flaws = char.flaws

      if (flaws.length > 0)
        flawsmsg = t('chargen.ok')
      else
        flawsmsg = t('chargen.oops_missing', :missing => "Flaws")
      end

      return (Chargen.format_review_status "\nChecking Powers.", powersmsg) + (Chargen.format_review_status "\nChecking Skills.", skillsmsg) + (Chargen.format_review_status "\nChecking Advantages.", advmsg) + (Chargen.format_review_status "\nChecking Flaws.", flawsmsg)

    end
  end
end