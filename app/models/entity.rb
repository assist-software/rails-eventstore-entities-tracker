class Entity < ApplicationRecord
  enum state: { 'New': 0, 'In use': 1, 'Broken': 2 }
  serialize :extra_data
end
