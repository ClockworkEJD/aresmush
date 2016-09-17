module AresMUSH
  module Handles
    class HandlesEventHandler
      include CommandHandler
          
      def on_char_connected_event(event)
        char = event.client.char
        return if !char.handle_id
        
        AresMUSH.with_error_handling(event.client, "Syncing handle with AresCentral.") do
          connector = Api::AresCentralConnector.new
        
          Global.logger.info "Updating handle for #{char.handle_id}"
          response = connector.sync_handle(char.handle_id, char.name, char.id)
          
          if (response.is_success?)
            if (response.data["linked"])
              char.autospace = response.data["autospace"]
              char.timezone = response.data["timezone"]
              Friends::Interface.sync_handle_friends(char, response.data["friends"])
              char.save!
              event.client.emit_success t('handles.handle_synced')              
            else
              char.handle_id = nil
              char.handle = nil
              char.save
              event.client.emit_success t('handles.handle_no_longer_linked')
              return
            end
          else
            raise "Response failed: #{response}"
          end
        end   
      end
    end
  end
end