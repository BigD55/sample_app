# By using the symbol ':user', we get Factory Girl to simulate the User model.
  Factory.define :user do |user|
     user.name "Michael Hartl"
     user.email "muppethartl@example.com"
     user.password "foobar"
     user.password_confirmation "foobar"
  end
  Factory.sequence :name do |n|
     "Person #{n}"
  end
  Factory.sequence :email do |n|
     "person-#{n}@example.com"
  end
  Factory.define :micropost do |micropost|
     micropost.content "Foo bar"
     micropost.association :user
  end
  Factory.define :blog do |blog|
     blog.title "irgendein bloeder Titel"
     blog.description "und das hier sollte den Titel noch was erlaeutern"
     blog.association :user
  end
  Factory.sequence :title do |n|
     "Beispiel-Titel-#{n}-Blabla"
  end
  Factory.sequence :description do |n|
     "Beispiel-Erklaerung-#{n}"
  end
  

