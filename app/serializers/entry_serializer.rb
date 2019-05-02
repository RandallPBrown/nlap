class EntrySerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :agent, :department, :occurrences, :value, :date, :description
  attribute :agent do |object|
    "#{object.user.full_name}"
  end

  attribute :department do |department|
  	"#{department.department.name}"
  end

  attribute :occurrences do |occurrences|
  	"#{occurrences.occurrence.name}"
  end

  attribute :value do |value|
  	"#{value.occurrence.ovalue}"
  end

  attribute :date do |date|
  	"#{date.edate}"
  end

  attribute :description do |description|
  	"#{description.edesc}"
  end
end
