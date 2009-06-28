require File.join(File.dirname(__FILE__), '../../lib/string')

class Quote < ActiveRecord::Base
  has_many :votes, 
           :dependent    => :destroy, 
           :after_add    => :calculate_score, 
           :after_remove => :calculate_score

  validates_each :text do |record, attribute, value|
    error = nil
    if value.blank?
      error = true
    else
      value.lines.each do |line|
        if not line.delimiter
          error = true
          break
        end
      end
    end
    if error
      record.errors.add(attribute, 'format must be Nick: Line or * Action for each line')
    end
  end
  
  named_scope :approved,
              :conditions => { :approved => true }
  named_scope :unapproved, 
              :conditions => { :approved => false }
  named_scope :by_score_desc,
              :order => 'score DESC'
  named_scope :by_created_at_desc, 
              :order => 'created_at DESC'
              
  def self.find_by_options(options = {})
    scope = self.scoped({})
    case options[:approval]
      when 'approved' then
        scope = scope.approved
      when 'unapproved' then
        scope = scope.unapproved
    end
    case options[:order]
      when 'score_desc' then
        scope = scope.by_score_desc
      when 'created_at_desc' then
        scope = scope.by_created_at_desc
    end
    scope
  end
  
  def text=(string)
    string = string.strip if string.is_a?(String)
    write_attribute(:text, string)
  end
  
  def lines
    return if not valid?
    return @lines if @lines
    @lines      = []
    identifiers = {}
    text.lines.each do |line|
      identifier = line.slice!(0..line.delimiter)
      if not identifiers.has_key?(identifier)
        if identifier.match(/\*/)
          style = 'action'
        else
          style = "colour_#{identifiers.size}"
        end
        identifiers[identifier] = style
      end
      @lines << Line.new(identifier, identifiers[identifier], line)
    end
    @lines
  end
      
  def number
    '#%04d' % id
  end
  
  private
  
    def calculate_score(vote)
      update_attribute(:score, self.score += vote.vote_type)
    end
end
