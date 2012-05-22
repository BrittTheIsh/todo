require 'librato/metrics'

class ListsController < ApplicationController

  def create
    aggregator = Librato::Metrics::Aggregator.new
    aggregator.time :list_create do
      @list = List.new(params[:list])
      @list.save ? flash[:notice] = "Your list was created" : flash[:alert] = "There was an error creating your list."
      redirect_to(list_tasks_url(@list))
    end
    aggregator.submit
  end

  def destroy
    aggregator = Librato::Metrics::Aggregator.new
    aggregator.time :list_destroy do
      @list = List.find(params[:id])
      @list.destroy

      respond_to do |format|
        format.html { redirect_to(root_url) }
      end
    end
    aggregator.submit
  end
end
