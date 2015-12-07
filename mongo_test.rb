require "mongoid"

Mongoid.load!("./mongoid.yml", :development)

=begin

# add special database user for the application: https://docs.mongodb.org/manual/tutorial/manage-users-and-roles/

 $ docker exec -it mongo /usr/bin/mongo -u "siteRootAdmin" -p "<password>" --authenticationDatabase "admin"
 $ use replica_test_db
 $ db.createUser(
    {
      user: "replica_test_db_user",
      pwd: "replica_test_db_user",
      roles: [
         { role: "dbOwner", db: "replica_test_db" }
      ]
    }
  )

$ docker run -it --rm=true --name mrdt hiogawa/mongo-ruby-docker-test:v0
irb(main):001:0> Person.count
D, [2015-12-07T01:46:17.690268 #9] DEBUG -- : MONGODB | Adding node1.example.com:27017 to the cluster.
D, [2015-12-07T01:46:17.695390 #9] DEBUG -- : MONGODB | Adding node2.example.com:27017 to the cluster.
D, [2015-12-07T01:46:17.699242 #9] DEBUG -- : MONGODB | Server node1.example.com:27017 elected as primary in rs0.
D, [2015-12-07T01:46:17.701741 #9] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.count | STARTED | {"count"=>"people", "query"=>{}}
D, [2015-12-07T01:46:17.702693 #9] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.count | SUCCEEDED | 0.000821695s
=> 1
irb(main):002:0> Person.create first_name: "jiro", last_name: "mongo"
D, [2015-12-07T01:51:08.636777 #10] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.insert | STARTED | {"insert"=>"people", "documents"=>[{"_id"=>BSON::ObjectId('5664e60c9da7d8000a000000'), "first_name"=>"jiro", "last_name"=>"mongo"}], "writeConcern"=>{:w=>1}, "ordered"=>true}
D, [2015-12-07T01:51:08.662927 #10] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.insert | SUCCEEDED | 0.025968846s
=> #<Person _id: 5664e60c9da7d8000a000000, first_name: "jiro", middle_name: nil, last_name: "mongo">
irb(main):003:0> Person.count
D, [2015-12-07T01:51:12.928759 #10] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.count | STARTED | {"count"=>"people", "query"=>{}}
D, [2015-12-07T01:51:12.929988 #10] DEBUG -- : MONGODB | node1.example.com:27017 | replica_test_db.count | SUCCEEDED | 0.001062199s
=> 2

# TODO
- check if writing/reading operation to mongodb works when two replica sets are disconnected

=end

class Person
  include Mongoid::Document
  field :first_name, type: String
  field :middle_name, type: String
  field :last_name, type: String
end
