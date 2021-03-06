Rails.application.routes.draw do
  # User Routes
  get '/' => 'tests#index'
  get '/test/view/:testid' => 'tests#testinfo'
  get '/test/register/:testid' => 'tests#register'
  get '/test/environment' => 'tests#environment'
  get '/test/changeproblem' => 'tests#changeproblem'
  post '/attempt' => 'tests#attempt'
  get '/test/scoreboard' => 'tests#scoreboard'
  get '/test/preenrolled' => 'tests#preenrolled'
  get '/test/submit' => 'tests#submit'

  get '/under_const' => 'application#under'
  get '/user/:userid' => 'application#profile'
  get '/user/edit/:userid' => 'application#editprofile'
  devise_for :users, :controllers => { registrations: 'registrations'}

  # Admin Routes
  get '/problem/new' => 'problems#new'
  get '/problem/edit/:problemid' => 'problems#edit'
  delete '/problem/delete' => 'problems#destroy'
  get '/test/new' => 'tests#new'
  post '/test/new' => 'tests#create'
  get '/test/mytests'=> 'tests#myTests'
  get '/test/edit/:testid' => 'tests#edit'
  post '/problem/new' => 'problems#create'
  patch '/test/edit/:testid' => 'tests#update'
  patch '/problem/edit/:problemid' => 'problems#update'

end
