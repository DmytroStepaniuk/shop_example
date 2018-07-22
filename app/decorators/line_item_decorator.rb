class LineItemDecorator < Draper::Decorator
  delegate_all

  def total 
    '%.2f$' % (model.total/100.0) 
  end

end
