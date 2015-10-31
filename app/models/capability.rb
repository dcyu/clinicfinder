class Capability < ActiveRecord::Base
  belongs_to :clinic
  belongs_to :topic
end
