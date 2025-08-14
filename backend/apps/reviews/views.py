from django.utils.decorators import method_decorator

from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from drf_yasg.utils import swagger_auto_schema

from .serializers import ReviewSerializer


class CreateNewReviewView(generics.GenericAPIView): # todo
    """
        create a new review
        (available for authenticated users)
    """
    serializer_class = ReviewSerializer
    permission_classes = (IsAuthenticated,)

    def post(self, request, *args, **kwargs):
        pass

#
# class DestroySpecificReviewView(generics.DestroyAPIView): # todo
#     """
#         delete a specific review by id
#         (available for superuser)
#     """
#     def delete(self, request, *args, **kwargs):
#         pass
#
#
# class GetAllReviewsView(generics.ListAPIView): # todo
#     """
#         get all reviews
#         (available for all users)
#     """
#     serializer_class = ReviewSerializer
#
#     def get(self, request, *args, **kwargs):
#         pass
#
#
# class UpdateSpecificReviewView(generics.UpdateAPIView): # todo
#     """
#         update a specific review by id
#         (available for owners)
#     """
#     serializer_class = ReviewSerializer
#     http_method_names = ("patch",)
#
#     def patch(self, request, *args, **kwargs):
#         pass
#
#
# class ShowUnapprovedReviewView(generics.GenericAPIView): # todo
#     """
#         show unapproved reviews
#         (available for superuser)
#     """
#     serializer_class = ReviewSerializer
#
#     def get(self, request, *args, **kwargs):
#         pass
#
#
# class ApproveReviewView(generics.UpdateAPIView): # todo
#     """
#         approve a review for publication
#         (available for superuser)
#     """
#     serializer_class = ReviewSerializer
#
#     def patch(self, request, *args, **kwargs):
#         pass
#
#
# # moderation before publication todo
# # limiting the number of comments from a specific user todo
#
#
#
#
#
#

