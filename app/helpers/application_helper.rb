module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "BillGuru"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("bill2.png", :alt => "BillGuru", :size => "50X50",:class => "round")
  end

  def app_name
     "BillGuru"
  end

  def alert_type_name(index)
      @alerts = ['Daily','Weekly','Monthly','Once every two months']
      return @alerts[index]
  end


end
