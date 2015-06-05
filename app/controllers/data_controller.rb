class DataController < ApplicationController
	before_action :set_login, only: [:show, :edit, :update, :destroy]

  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all
  end
	

	def show_kills
	end





end