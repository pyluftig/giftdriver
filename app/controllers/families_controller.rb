class FamiliesController < ApplicationController

  before_filter :validate_organizer, except: [:index, :show, :adopt]

  def index
    @adopted = Family.adopted_families(params[:drive_id])
    @not_adopted = Family.not_adopted_families(params[:drive_id])
  end

  def create
    @family = Family.new
    @family.drive = Drive.find(params[:drive_id])
    @family.code = params[:family][:code]

    if @family.save
      redirect_to family_path(@family.id)
    else
      flash[:alert] = "That didn't work out quite right"
      redirect_to drive_path(params[:drive_id])
    end
  end

  def show
    @family = Family.find(params[:id])
  end

  def adopt
    @family = Family.find(params[:id])

    if @family.save
      @family.update_attribute(:adopted_by, current_user.id)
      flash[:message] = "THANK YOU!"
      redirect_to family_path(@family.id)
    else
      flash[:alert] = "Something went wrong. Try again?"
      redirect_to family_path(@family.id)
    end
  end

  protected

  def validate_organizer
    redirect_to root_url unless Drive.find(params[:drive_id]).user == current_user
  end

end
