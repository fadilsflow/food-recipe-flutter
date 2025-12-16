Description: Log in a user

URL: /api/login

Method: POST

Parameters:

email (required) - The user's email
password (required) - The user's password
Response (200):

{
"status": "success",
"message": "Login successful",
"data": {
"user": {
"id": 1,
"name": "User Name",
"email": "user@example.com"
},
"token": "auth_token"
}
}
Error Response (401):

{
"status": "error",
"message": "Invalid credentials"
}
