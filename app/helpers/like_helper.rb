module LikeHelper
    def unlike_post()
        @like.destroy
        decrement_like_count()
        delete_interaction_history()
    end
    def like_post()
        Like.create(user: @current_user, post: @post)
        increment_like_count()
        add_interaction_history()
    end
    def increment_like_count()
        @post.like_count = @post.like_count + 1
        @post.save
    end
    def decrement_like_count()
        @post.like_count = @post.like_count - 1
        @post.save
    end
    def add_interaction_history()
        if !(@current_user.interaction_histories.exists?(post_id: @post.id))
            @current_user.interaction_histories.create(post: @post, interaction_type: "like")
        end
    end 
    def delete_interaction_history()
        interaction_history = @current_user.interaction_histories.find_by(post: @post)
        interaction_history.destroy
    end
end
