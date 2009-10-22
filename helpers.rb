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
        (#{'+' if count > 0}#{count} Votes)
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
    string = string.gsub(/\A(.*)\Z/, ' \1 ')                           # Pad with whitespace for quote substitution, else won't match on ^ or $
    string = string.gsub(/\*(\S[^\*]+\S)\*/, '<em>\1</em>')            # *match match*, *not match *, * not match *, * not match*
    string = string.gsub(/\s"([^"]+)"([\s\W])/, ' &ldquo;\1&rdquo;\2') # "match", "match"!, not"match", not"match
    string = string.gsub(/\s'([^']+)'([\s\W])/, ' &lsquo;\1&rsquo;\2') # 'match', not'match', not'match
    string = string.gsub(/'\s/, '&rsquo; ')                            # N' -> N’
    string = string.gsub(/(\s)?'/, '\1&lsquo;')                        # 'N -> ‘N 
    string = string.gsub(/"/, '&rdquo;')
    string = string.strip
    string
  end
    
  def h(string)
    string = string.gsub(/&/, '&amp;')
    string = string.gsub(/>/, '&gt;')
    string = string.gsub(/</, '&lt;')
    string
  end
end
