class StaticPagesController < ApplicationController
  def home
  end
  
  def generate
        num = rand(19)+1
        #while (Adventure.find(num).summary != NULL) {
        Adventure.find(num).summary
  end


  def submit
  end
end
