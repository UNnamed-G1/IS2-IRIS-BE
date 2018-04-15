class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected 
    def self.presence_msg(field)
      return "El campo " + field + " es obligatorio."
    end
end
