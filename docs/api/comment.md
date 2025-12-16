GET /api/recipes/{recipe}/comments
Description: Get all comments for a recipe

URL: /api/recipes/{recipe}/comments

Method: GET

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
Response (200):

{
"status": "success",
"message": "Comments retrieved successfully",
"data": {
"comments": [
{
"id": 1,
"user_id": 1,
"recipe_id": 1,
"comment": "Great recipe!",
"created_at": "2024-10-22T01:24:44.000000Z",
"updated_at": "2024-10-22T01:24:44.000000Z",
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
}
}
],
"comment_count": 1
}
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
GET /api/recipes/{recipe}/comments
POST /api/recipes/{recipe}/comments
Description: Create a new comment on a recipe

URL: /api/recipes/{recipe}/comments

Method: POST

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
Body Parameters:

comment (required, string, max 1000 characters) - The comment text
Response (201):

{
"status": "success",
"message": "Comment added successfully",
"data": {
"id": 1,
"user_id": 1,
"recipe_id": 1,
"comment": "Great recipe!",
"created_at": "2024-10-22T01:24:44.000000Z",
"updated_at": "2024-10-22T01:24:44.000000Z",
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
}
}
}
Error Response (422):

{
"status": "error",
"message": "Validation failed",
"errors": {
"comment": ["The comment field is required."]
}
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
GET /api/recipes/{recipe}/comments/{comment}
Description: Get a specific comment by ID

URL: /api/recipes/{recipe}/comments/{comment}

Method: GET

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
comment (required) - Comment ID
Response (200):

{
"status": "success",
"message": "Comment retrieved successfully",
"data": {
"id": 1,
"user_id": 1,
"recipe_id": 1,
"comment": "Great recipe!",
"created_at": "2024-10-22T01:24:44.000000Z",
"updated_at": "2024-10-22T01:24:44.000000Z",
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
}
}
}
Error Response (400):

{
"status": "error",
"message": "Comment does not belong to this recipe"
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}
PUT /api/recipes/{recipe}/comments/{comment}
Description: Update a comment. Only the comment owner can update their own comment.

URL: /api/recipes/{recipe}/comments/{comment}

Method: PUT

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
comment (required) - Comment ID
Body Parameters:

comment (required, string, max 1000 characters) - The updated comment text
Response (200):

{
"status": "success",
"message": "Comment updated successfully",
"data": {
"id": 1,
"user_id": 1,
"recipe_id": 1,
"comment": "Updated comment text",
"created_at": "2024-10-22T01:24:44.000000Z",
"updated_at": "2024-10-22T01:25:00.000000Z",
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
}
}
}
Error Response (403):

{
"status": "error",
"message": "Unauthorized. You can only update your own comments"
}
Error Response (422):

{
"status": "error",
"message": "Validation failed",
"errors": {
"comment": ["The comment field is required."]
}
}
DELETE /api/recipes/{recipe}/comments/{comment}
Description: Delete a comment. Only the comment owner can delete their own comment.

URL: /api/recipes/{recipe}/comments/{comment}

Method: DELETE

Headers:

Authorization (required) - Bearer token
URL Parameters:

recipe (required) - Recipe ID
comment (required) - Comment ID
Response (200):

{
"status": "success",
"message": "Comment deleted successfully"
}
Error Response (403):

{
"status": "error",
"message": "Unauthorized. You can only delete your own comments"
}
Error Response (400):

{
"status": "error",
"message": "Comment does not belong to this recipe"
}
