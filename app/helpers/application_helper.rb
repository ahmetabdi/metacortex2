module ApplicationHelper
  def site_image_to_image(site)
    case site
    when "2ddl.tv"
      "2ddl.png"
    when "ul.to"
      "ul_to.png"
    end
  end
end
