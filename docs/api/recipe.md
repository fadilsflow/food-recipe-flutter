Description: Retrieve a paginated list of recipes

URL: /api/recipes

Method: GET

Headers:

Authorization (required) - Bearer token
Response (200):

{
"status": "success",
"message": "Recipes retrieved successfully",
"data": {
"current_page": 1,
"data": [
{
"id": 3,
"user_id": 3,
"title": "judul 5",
"description": "deskripsi 1",
"cooking_method": "cooking 5",
"ingredients": "inggridiens 1",
"photo_url": "https://freeapi.tahuaci.com/storage/photos/kFEqdkGkcG8XAf8OiAnps0tuORwLdFAFQlaAGLag.jpg",
"created_at": "2024-10-30T02:52:02.000000Z",
"updated_at": "2024-11-05T04:15:45.000000Z",
"likes_count": 2,
"comments_count": 0,
"user": {
"id": 3,
"name": "Arif",
"email": "hyda.arif2@gmail.com",
"email_verified_at": null,
"created_at": "2024-10-22T08:35:00.000000Z",
"updated_at": "2024-10-22T08:35:00.000000Z"
}
},
...
],
"first_page_url": "http://127.0.0.1:8000/api/recipes?page=1",
"from": 1,
"next_page_url": null,
"path": "http://127.0.0.1:8000/api/recipes",
"per_page": 12,
"prev_page_url": null,
"to": 3
}
}

POST /api/recipes
Description: Create a new recipe

URL: /api/recipes

Method: POST

Headers:

Authorization (required) - Bearer token
Parameters:

title (required) - The title of the recipe
cooking_method (required) - The method of cooking
ingredients (required) - The ingredients
description (required) - Recipe description
photo (required, image) - Recipe image file
Response (201):

{
"status": "success",
"message": "Recipe created successfully",
"data": { "id": 1, "title": "Recipe Title", ... }
}
Error Response (422):

{
"status": "error",
"message": "Validation failed",
"errors": { "title": ["The title field is required."] }
}

GET /api/recipes/{id}
Description: Retrieve a specific recipe by ID

URL: /api/recipes/{id}

Method: GET

Headers:

Authorization (required) - Bearer token
Response (200):

{
"status": "success",
"message": "Recipe retrieved successfully",
"data": { "id": 1, "title": "Recipe Title", ... }
}
Error Response (404):

{
"status": "error",
"message": "Recipe not found"
}

PUT /api/recipes/{id}
Description: Update an existing recipe

URL: /api/recipes/{id}

Method: PUT

Headers:

Authorization (required) - Bearer token
Parameters: (All parameters are optional - only include fields you want to update)

title (optional) - The title of the recipe
cooking_method (optional) - The method of cooking
ingredients (optional) - The ingredients
description (optional) - Recipe description
Note: The photo cannot be modified. Only the recipe owner can update their own recipes.

Response (200):

{
"status": "success",
"message": "Recipe updated successfully",
"data": { "id": 1, "title": "Updated Recipe Title", ... }
}
Error Response (403):

{
"status": "error",
"message": "Unauthorized. You can only update your own recipes"
}
Error Response (422):

{
"status": "error",
"message": "Validation failed",
"errors": {
"title": ["The title field is required."]
}
}
Error Response (500):

{
"status": "error",
"message": "Failed to update recipe",
"error": "error_details"
}
DELETE /api/recipes/{id}
Description: Delete a recipe by ID. Only the recipe owner can delete their own recipes.

URL: /api/recipes/{id}

Method: DELETE

Headers:

Authorization (required) - Bearer token
Response (200):

{
"status": "success",
"message": "Recipe deleted successfully"
}
Error Response (403):

{
"status": "error",
"message": "Unauthorized. You can only delete your own recipes"
}
Error Response (500):

{
"status": "error",
"message": "Failed to delete recipe",
"error": "error_details"
}
