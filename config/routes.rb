Fedena::Application.routes.draw do 
  
  scope '(:locale)' do
    resources :grading_levels
    resources :ranking_levels do
      collection do
	    get  :create_ranking_level
	    post :create_ranking_level
  	    get  :edit_ranking_level
	    post :edit_ranking_level
     	get  :update_ranking_level
	    post :update_ranking_level
	    get  :delete_ranking_level
	    post :delete_ranking_level
	    get  :ranking_level_cancel
	    post :ranking_level_cancel
	    get  :change_priority
	    post :change_priority
      end
    end
    resources :class_designations
	resources :class_timings
	resources :subjects
	resources :attendances do
	  collection do
	    get  :daily_register
		get  :subject_wise_register
	  end
	end
    resources :employee_attendances
    resources :attendance_reports
	resources :cce_exam_categories
    resources :assessment_scores do
	  collection do
	    get  :exam_fa_groups
		get  :observation_groups
	  end
	end
	resources :cce_settings do
	  collection do
	    get  :basic
		get  :scholastic
		get  :co_scholastic
      end
    end	  
	resources :scheduled_jobs, except:  [:show]
	resources :fa_groups do
	   collection do
	     get  :assign_fa_groups
		 post :assign_fa_groups
		 get  :new_fa_criteria
		 post :get,:post
		 get  :create_fa_criteria
		 post :create_fa_criteria
		 get  :edit_fa_criteria
		 post :edit_fa_criteria
		 get  :update_fa_criteria
		 post :update_fa_criteria
		 post :destroy_fa_criteria
		 get  :reorder
		 post :reorder
	  end
	end
    resources :fa_criterias do 
      resources :descriptive_indicators do 
        resources :assessment_tools
	  end
    end
    resources :observations do
      resources :descriptive_indicators do
        resources :assessment_tools
      end
    end
	
	resources :observation_groups do
	  get  :new_observation, :on => :member
	  post :new_observation, :on => :member
	  get  :create_observation
	  post :create_observation
	  get  :edit_observation
	  post :edit_observation
	  get  :update_observation
	  post :update_observation
	  post :destroy_observation
	  get  :reorder
	  post :reorder
	  collection do
	    get  :assign_courses
		post :assign_courses
		get  :set_observation_group
		post :set_observation_group
	  end
	end
	resources :cce_weightages do
	  get  :assign_courses, :on => :member
	  post :assign_courses, :on => :member
	  collection do
	    get  :assign_weightages
		post :assign_weightages
	  end
	end
	
	resources :cce_grade_sets do 
	  get  :new_grade, :on => :member
	  post :new_grade, :on => :member
	  get  :edit_grade
	  post :edit_grade
	  get  :update_grade
	  post :update_grade
	  post :destroy_grade
	end
    
	match 'courses/manage_course' => 'courses#manage_course', :as => :feed
	match 'courses/manage_batches' => 'courses#manage_batches', :as => :feed

	resources :courses do
	  resources :batches
	  collection do
	    get  :grouped_batches
		post :grouped_batches
		get  :create_batch_group
		post :create_batch_group
		get  :edit_batch_group
		post :edit_batch_group
		get  :update_batch_group
		post :update_batch_group
		get  :delete_batch_group
		post :delete_batch_group
	  end  
	end

	resources :batches do
	  resources :exam_groups
	  #resources :additional_exam_groups
      resources :elective_groups
    end
	resources :exam_groups do
      resources :exams do
        post :save_scores, on:  :member
      end
    end
	
	resources :timetables do
      resources :timetable_entries
    end
	
	root to: 'user#login', as: 'login'
	
	# map.fa_scores 'assessment_scores/exam/:exam_id/fa_group/:fa_group_id', :controller=>'assessment_scores',:action=>'fa_scores'
    # map.observation_scores 'assessment_scores/batch/:batch_id/observation_group/:observation_group_id', :controller=>'assessment_scores',:action=>'observation_scores'
    # map.scheduled_task 'scheduled_jobs/:job_object/:job_type',:controller => "scheduled_jobs",:action => "index"
    # map.scheduled_task_object 'scheduled_jobs/:job_object',:controller => "scheduled_jobs",:action => "index"

	match 'assessment_scores/exam/:exam_id/fa_group/:fa_group_id' => "assessment_scores#fa_scores"
	match 'assessment_scores/batch/:batch_id/observation_group/:observation_group_id' => "assessment_scores#observation_scores"
    match 'scheduled_jobs/:job_object/:job_type' => "scheduled_jobs#index"
    match 'scheduled_jobs/:job_object' => "scheduled_jobs#index"

    match ':controller(/:action(/:id))'
    match ':controller/:action'
    match ':controller/:action/:id/:id2'
    match ':controller/:action/:id(.:format)'
	
	# these bellow may not be needed. run tests and check what is happening
	
    resources :attendance
	
	resources :custom_settings
     
	resources :employee do
	  collection do
	    get :hr
	  end
	end
	resources :finance
    resources :exam do
	  collection do
	    get  :grouping
	  end
	end
	
    resources :student do
	  resources :attendance
	  collection do
	    get :admission1
		get :view_all
		get :advanced_search
	  end
	end
	resources :reminder
	resources :timetable
	resources :news
    resources :user do
	  collection do 
	    post :forgot_password
		get  :dashboard
		get  :profile
		get  :logout
		get  :login
	  end
	end
    
  end
end