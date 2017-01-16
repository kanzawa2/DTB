class ReuseRelationship < ActiveRecord::Base
  belongs_to :source, class_name: 'Mission'
  belongs_to :destination, class_name: 'Mission'
end
