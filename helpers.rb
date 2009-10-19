helpers do
  def sign_and_style_votes_count(count)
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
  
  def humanised_datetime(datetime)
    datetime.strftime("%A, %d %B %Y")
  end
  
  def odd_even(int)
    if int % 2 == 0
      "even"
    else
      "odd"
    end
  end
  
  def pretty(string)
    string = string.gsub('&', '&amp;')
    string = string.gsub(/\*([^\*]+)\*/, '<em>\1</em>');
    string = string.gsub(/'([^']+)'/, '&lsquo;\1&rsquo;')
    string = string.gsub(/"([^"]+)"/, '&ldquo;\1&rdquo;')
    string = string.gsub('\'', '&rsquo;')
  end
end
