server "167.99.137.232", user: "deployer", roles: %w{app db web}, primary: true

role :app, %w{deployer@167.99.137.232}
role :web, %w{deployer@167.99.137.232}
role :db,  %w{deployer@167.99.137.232}

set :rails_env, :production

set :ssh_options, {
   keys: %w(/home/etkachenko/.ssh/id_rsa),
   forward_agent: true,
   auth_methods: %w(publickey password),
   port: 4321
 }
