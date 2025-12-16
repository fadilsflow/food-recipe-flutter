POST /api/register
Description: Register a new user

URL: /api/register

Method: POST

Parameters:

name (required) - The user's name
email (required, unique) - The user's email
password (required, min 6 characters) - The user's password
Response (201):

{
"status": "success",
"message": "Registration successful",
"data": {
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
},
"token": "auth_token"
}
}
Error Response (422):

{
"status": "error",
"message": "Validation failed",
"errors": {
"email": ["The email has already been taken."]
}
}
Error Response (500):

{
"status": "error",
"message": "Failed to register user",
}
