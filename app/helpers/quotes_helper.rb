module QuotesHelper
  def render_score(score)
    if score > 2
      html_class = 'positive'
    elsif score < -2
      html_class = 'negative'
    else
      html_class = 'neutral'
    end
    score = "+#{score}" if score > 0
    content_tag :span, "(#{score})", :class => html_class
  end  
  
  def render_formatted_date_time(date_time)
    if date_time > 1.week.ago
      time_ago_in_words(date_time) + ' ago'
    else
      date_time.strftime("%A, #{date_time.day.ordinalize} %B %Y")
    end
  end
  
  def render_italic_and_bold(string)
    BlueCloth.new.transform_italic_and_bold(h(string), nil)
  end
end
