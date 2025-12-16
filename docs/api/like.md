POST /api/recipes/{recipe}/like
Description: Toggle like/unlike a recipe. If already liked, it will unlike. If not liked, it will like.

URL: /api/recipes/{recipe}/like

Method: POST

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
Response (200):

{
"status": "success",
"message": "Recipe liked successfully",
"data": {
"is_liked": true,
"like_count": 5
}
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
POST /api/recipes/{recipe}/like
DELETE /api/recipes/{recipe}/unlike
Description: Unlike a recipe

URL: /api/recipes/{recipe}/unlike

Method: DELETE

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
Response (200):

{
"status": "success",
"message": "Recipe unliked successfully",
"data": {
"is_liked": false,
"like_count": 4
}
}
Error Response (400):

{
"status": "error",
"message": "You have not liked this recipe"
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
GET /api/recipes/{recipe}/likes
Description: Get all likes for a recipe

URL: /api/recipes/{recipe}/likes

Method: GET

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
Response (200):

{
"status": "success",
"message": "Likes retrieved successfully",
"data": {
"likes": [
{
"id": 1,
"user_id": 1,
"recipe_id": 1,
"created_at": "2024-10-22T01:24:44.000000Z",
"updated_at": "2024-10-22T01:24:44.000000Z",
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
}
}
],
"like_count": 1,
"is_liked": true
}
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
