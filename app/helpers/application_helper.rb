module ApplicationHelper
 
 def logo
# <a href="/"><img alt="Sample App" class="round" src="/images/logo.png" /></a>

 end

 def title
   base_title = "Ruby on Rails diminishes spirituality"
   if @title.nil?
      base_title
   else 
      "#{base_title}| #{@title}"
   end
 end
end
