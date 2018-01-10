Rails.application.routes.draw do
  # User Routes
  get '/' => 'tests#index'
  get '/test/view/:testid' => 'tests#testinfo'
  get '/test/register/:testid' => 'tests#register'
  get '/test/environment' => 'tests#environment'
  get '/test/changeproblem' => 'tests#changeproblem'
  post '/attempt' => 'tests#attempt'
  
  devise_for :users, :controllers => { registrations: 'registrations'}

  # Admin Routes
  get '/problem/new' => 'problems#new'
  get '/problem/edit/:problemid' => 'problems#edit'
  get '/test/new' => 'tests#new'
  post '/test/new' => 'tests#create'
  get '/test/mytests'=> 'tests#myTests'
  get '/test/edit/:testid' => 'tests#edit'
  post '/problem/new' => 'problems#create'
  patch '/test/edit/:testid' => 'tests#update'
  patch '/problem/edit/:problemid' => 'problems#update'

end
