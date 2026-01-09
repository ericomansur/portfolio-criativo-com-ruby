class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]

  skip_before_action :authenticate_user!, only: :public_show

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "Projeto criado"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Projeto atualizado"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Projeto removido"
  end

  def public_show
    @user = User.find_by!(username: params[:username])
    @project = @user.projects.find_by!(
      slug: params[:project_slug],
      public: true
    )
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :image, :public)
  end
end
