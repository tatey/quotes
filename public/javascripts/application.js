$(document).ready(function() {
  if ($('div#new_quote').length) {
    showNotification('Quote has been submitted successfully.', 5000);
    $('div#new_quote').remove();
  }
  
  $('a#top').click(function() {
    $(this).blur();
    $.scrollTo(0, 500);
    return false;
  });

  $('ul.actions li').each(function () {
    var form = $(this).find('form');
    var a = $('<a></a>')
    a.attr('href', form.attr('action'));
    a.attr('class', 'vote');
    a.html(form.find('input').attr('value'));
    a.prependTo(this);
    form.hide();
  });
  
  $('a.vote').each(function() {
    $(this).click(function() {
      var quoteId = this.href.match(/quote\/(\d+)/)[1];
      var span = $('#votes_count_' + quoteId + ' span');
      var votesCount = parseInt(span.text().match(/-?\d+/));
      var voteType = parseInt(this.href.match(/-?\d$/));
      votesCount += voteType;
      span.removeClass();
      if (votesCount > 2) {
        span.attr('class', 'positive');
      } else if (votesCount < -2) {
        span.attr('class', 'negative');
      } else {
        span.attr('class', 'neutral');
      }
      span.text('(' + signInt(votesCount) + ' Votes)');
      if (voteType >= 1) {
        showNotification('&#9650; Up vote cast for #' + pad(quoteId), 3000);
      } else {
        showNotification('&#9660; Down vote cast for #' + pad(quoteId), 3000);
      }
      $.post(this.href);
      return false;
    })
  });
  
  $('#quote_text').bind('keyup focus', function() {
    var preview = $('#preview');
    if (! preview.length) {
      $('form').after(
        '<h2>Preview</h2>' + 
        '<div id="quote">' +
          '<blockquote><p id="preview"></p></blockquote>' +
          '<div class="clear_both"></div>' +
        '</div>'
      );
    }
    else {
      preview.stopTime('preview');
    }
    preview.oneTime(500, 'preview', function() {
      var lines = $('#quote_text').val().split("\n").map(function(line) {
        var regex = /^(\s*\*|[^:]+:)\s*(.+)\s*/;
        if (line.match(regex)) {
          return line.replace(regex, function() { 
            return '<span class="identifier">' + sanitise(arguments[1]) + '</span>' +
                   '<span class="text">' + sanitise(arguments[2]) + '</span>' +
                   '<br/>'
            }
          );          
        } else {
          return sanitise(line);
        }
      });
      preview.html(lines.join("\n"));
    });
  });
});

function pad(int) {
  var string = int.toString();
  while (string.length < 4) {
    string = '0' + string;
  }
  return string;
}

function signInt(int) {
  return int > 0 ? '+' + int : int.toString();
}

// Borrowed from Prototype's stripTags();
function sanitise(string) {
  return string.replace(/<\/?[^>]+>/g, '');
}

function showNotification(message, duration) {
  var notification = $('#notification');
  if (! notification.length) {
    notification = $('<div></div>');
    notification.attr('id', 'notification');
    notification.prependTo($(document.body));
  } else {
    notification.stopTime('notification');
  }
  notification.html(message);
  notification.fadeIn('slow');
  notification.oneTime(duration, 'notification', function() {
    notification.fadeOut('slow', function() {
      notification.remove();
    });
  });
}
