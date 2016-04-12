module ApplicationHelper
    #Returns full title on per-page basis
    def full_title(page_title = '')
        base_title = "Ruby on Rails Tutorial Sample App"
        if page_title.empty? #check if page_title is not nil
            base_title
        else
            page_title + " | " + base_title
        end 
    end
end
