module QuotesHelper
  def render_score(score)
    if score > 0
      html_class = 'positive'
    elsif score < 0
      html_class = 'negative'
    else
      html_class = 'neutral'
    end
    content_tag :span, "Score #{score}", :class => html_class
  end
end
