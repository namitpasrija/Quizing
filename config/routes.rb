Rails.application.routes.draw do
  devise_for :users
  get '/' => 'tests#index'
  get '/problem/new' => 'problems#new'
  get '/problem/edit/:problemid' => 'problems#edit'
  post '/problem/new' => 'problems#create'
  get '/test/new' => 'tests#new'
  get '/test/edit/:testid' => 'tests#edit'
  post '/test/new' => 'tests#create'
  get '/test/mytests'=> 'tests#myTests'
  get '/test/instructions'=> 'tests#instructions'
  get '/test/environment' => 'tests#environment'
  patch '/problem/edit/:problemid' => 'problems#update'
  post '/attempt' => 'tests#attempt'
  get '/test/changeproblem' => 'tests#changeproblem'
end
