helpers do
  def render_votes_count(count)
    if count > 2
      html_class = 'positive'
    elsif count < -2
      html_class = 'negative'
    else
      html_class = 'neutral'
    end
    %{
      <span class="#{html_class}">
        (#{'+' if count > 0}#{count})
      </span>
    }
  end
  
  def render_formated_datetime(datetime)
    datetime.strftime("%A, %d %B %Y")
  end
  
  def odd_or_even(int)
    if int % 2 == 0
      "even"
    else
      "odd"
    end
  end
end
