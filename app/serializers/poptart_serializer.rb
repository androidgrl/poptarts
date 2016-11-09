#if you took this out it would still work but be slower
class PoptartSerializer < ActiveModel::Serializer
  attributes :flavor, :sprinkles
  #rails automatically default to this
end
