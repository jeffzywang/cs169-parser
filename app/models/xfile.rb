class Xfile < ActiveRecord::Base
  require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
  require 'crack/xml' # Only XML parsing
  require 'json'
  attr_accessible :name, :content

  def self.get_properties_from_string(h)
    return self.get_properties(eval(h))
  end
  def self.get_properties(h)
    new_array = []
    if h.is_a?(Hash)
      h.each_pair do |key, val|
        if new_array.exclude?(key)
          new_array = new_array + [key]
        end
        new_keys = get_properties(val)
        new_keys.each do |k|
          if new_array.exclude?(k)
            new_array = new_array + [k]
          end
        end
      end
    elsif h.is_a?(Array) && h[0].is_a?(Hash)
      h.each do |hash|
        new_array = new_array + get_properties(hash)
      end
    else
      return []
    end
    return new_array
  end

end
