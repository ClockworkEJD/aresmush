module AresMUSH
    class Character
    
    include MongoMapper::Document
    
    key :name, String
    key :name_upcase, String
    key :password_hash, String
        
    belongs_to :room, :class_name => 'AresMUSH::Room'
    
    before_validation :save_upcase_name
    after_save :reload_client_cache
    
    def change_password(raw_password)
      @password_hash = Character.hash_password(raw_password)
    end
    
    def compare_password(entered_password)
      hash = BCrypt::Password.new(@password_hash)
      hash == entered_password
    end
    
    def self.find_all_by_name_or_id(name_or_id)
      where( { :$or => [ { :name_upcase => name_or_id.upcase }, { :id => name_or_id } ] } ).all
    end
    
    def self.find_by_name(name)
      find_by_name_upcase(name.upcase)
    end

    def self.exists?(name)
      existing_char = Character.find_by_name(name)
      return !existing_char.nil?
    end    
    
    def self.hash_password(password)
      BCrypt::Password.create(password)
    end
        
    def save_upcase_name      
      @name_upcase = @name.nil? ? "" : @name.upcase
    end
    
    def reload_client_cache
      client = Global.client_monitor.find_client(self)
      if (!client.nil?)
        client.char.reload
      end
    end
  end
end
    