class CompanyTagEvent < TagEvent

  def set_tags
    taggable.employments.each do |job|
      job.tags.each do |t| 
        tag t
      end
    end    
  end

end
