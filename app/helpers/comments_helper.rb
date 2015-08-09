module CommentsHelper
  def unique_id_generator(record)
    record.class.name.downcase + '__' + record.id.to_s
  end
end
