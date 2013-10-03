class SetupController < ApplicationController
  def index
    @setup = %w(categories products)
  end
end
