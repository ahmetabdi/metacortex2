module ApplicationHelper
  def site_image_to_image(site)
    case site
    when "2ddl.tv"
      "2ddl.png"
    when "ul.to"
      "ul_to.png"
    when "nitroflare.com"
      "nitroflare.png"
    when "rapidgator.net"
      "rapidgator.png"
    when "go4up.com"
      "go4up.png"
    when "zippyshare.com"
      "zippyshare.png"
    when "hugefiles.net"
      "hugefiles.png"
    end
  end

  def page_meta_title
    if content_for(:meta_title)
      content_for(:meta_title) + " - NinjaPig - Direct Stream Full HD Movies for FREE!"
    else
      "NinjaPig - Direct Stream Full HD Movies for FREE!"
    end
  end
end
