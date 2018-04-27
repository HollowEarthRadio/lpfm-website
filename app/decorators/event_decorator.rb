class EventDecorator < Draper::Decorator
  decorates :event
  delegate_all

  def hint_image
    if object.event_image.present?
      h.image_tag(object.event_image.url(:cropped))
    else
      "Upload an image to go with your event"
    end
  end
end
