class LineItemDecorator < Draper::Decorator
  delegate_all

  def total 
    '%.2f$' % (object.total/100.0) 
  end

end
