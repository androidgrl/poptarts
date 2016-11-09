class HalloweenPoptartSerializer < ActiveModel::Serializer
  #just sends out a string instead of an object, faster
  attributes :flavor, :sprinkles
  root false
  #wanted root false because the key was halloween_poptart
  #root false customizes the payload being sent out, it takes out the poptart key
  #when things go through serializer it uses the attributes
  #it's how you tell rails what info is allowed to be sent out
  #no params in serializer, because it sits on top of controller

  def flavor
    #object is whatever object you're passing through
    "Spooky #{object.flavor}"
  end

  def sprinkles
    "Spooky #{object.sprinkles}"
  end
end
