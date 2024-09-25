TODO: 

# 1: child??? 

https://buttercms.com/blog/json-serialization-in-rails-a-complete-guide/

# app/views/post.rabl

object @job

attributes :id, :title, :content

child :comments do
  extends "comment"
end

# app/views/comment.rabl

object @comment

attributes :id, :author, :body


# Concerns folder??  what's for