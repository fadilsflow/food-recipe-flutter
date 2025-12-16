POST /api/logout
Description: Log out the current user

URL: /api/logout

Method: POST

Headers:

Authorization (required) - Bearer token
Response (200):

{
"status": "success",
"message": "Logged out successfully"
}
Error Response (500):

{
"status": "error",
"message": "Failed to log out",
"error": "error_details"
}
