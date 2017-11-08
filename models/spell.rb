require 'json'

class Spell

  def initialize(params)
    @classification = params["Classification"]
    @effect = params["Effect"]
    @name = params["Spell(Lower)"]
    @formatted_name = params["Spell"]
  end

  attr_reader :classification, :effect, :name, :formatted_name

  def self.data
    path = 'data/spells.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

  def self.effects
    data.map{|el| el["Effect"]}
  end

  # These two methods are used to validate answers
  def self.is_spell_name?(str)
    data.index { |el| el["Spell(Lower)"] == (str.downcase) }
  end

  def self.is_spell_name_for_effect?(name, effect)
    data.index { |el| el["Spell(Lower)"] == name && el["Effect"] == effect }
  end

  # To get access to the collaborative repository, complete the methods below.

  # Spell 1: Reverse
  # This instance method should return the reversed name of a spell
  # Tests: `bundle exec rspec -t reverse .`
  def reverse_name
    return name.reverse
  end

  # Spell 2: Counter
  # This instance method should return the number
  # (integer) of mentions of the spell.
  # Tests: `bundle exec rspec -t counter .`
  def mention_count
      #use mention.rb file
      mArr = Mention.data
      counter = 0
      
      for m in mArr
        if name == m["Spell"]
            counter += 1
        end
      end
              
     return counter
  end

  # Spell 3: Letter
  # This instance method should return an array of all spell names
  # which start with the same first letter as the spell's name
  # Tests: `bundle exec rspec -t letter .`
  def names_with_same_first_letter
      spells = Spell.data
      spellArr = []
      
      for s in spells
          if name[0] == s["Spell(Lower)"][0]
              spellArr.push(s["Spell(Lower)"]) #adding it to array
          end
      end
      
      return spellArr
  end

  # Spell 4: Lookup
  # This class method takes a Mention object and
  # returns a Spell object with the same name.
  # If none are found it should return nil.
  # Tests: `bundle exec rspec -t lookup .`
  def self.find_by_mention(mention)
    spells = Spell.data

    for s in spells
        #take mention object name (default lower) and look for it in Spell.data
        if mention.name == s["Spell(Lower)"]
            #create new Spell object
            found = Spell.new({"Classification" => s["Classification"],
               "Effect" => s["Effect"],
               "Spell(Lower)" => s["Spell(Lower)"],
               "Spell" => s["Spell"]})
            return found
        end
    end
    return nil
  end

end
