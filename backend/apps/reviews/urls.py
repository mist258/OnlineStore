from django.urls import path

from .views import (  # DestroySpecificReviewView,; GetAllReviewsView,; ShowUnapprovedReviewView,; UpdateSpecificReviewView,; ApproveReviewView,
    CreateNewReviewView,
)

urlpatterns = [
    path(
        "", CreateNewReviewView.as_view(), name="create_new_review"
    ), # create new review todo
    # path(
    #     "/<int:pk>/update", UpdateSpecificReviewView.as_view(), name="update_review_by_id"
    # ), # owner can update own review todo
    # path(
    #     "/<int:pk>/deletion", DestroySpecificReviewView.as_view(), name="delete_review_by_id"
    # ), # superuser can delete any review todo
    # path(
    #     "", GetAllReviewsView.as_view(), name="get_all_reviews"
    # ), # show all reviews todo
    # path(
    #     "<int:pk>/approve", ApproveReviewView.as_view(), name="approve_review_before_publication"
    # ), # superuser should approve the review before publication todo
    # path(
    #     "<int:pk>/unaproved", ShowUnapprovedReviewView.as_view(), name="show_not_approved_review"
    # ) # superuser can view all unapproved reviews that awaiting confirmation todo
    #

]
