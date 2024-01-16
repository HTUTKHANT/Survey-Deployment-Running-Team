<?php
// Replace these variables with your database credentials
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "dt3";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}

// Retrieve survey questions from the database
$sql = "SELECT * FROM question";
$result = $conn->query($sql);

// Check if there are questions
if ($result->num_rows > 0) {
   $questions = array();

   // Fetch questions and store in an array
   while($row = $result->fetch_assoc()) {
       $questions[] = $row;
   }

   // Convert questions array to JSON for front-end
   $questions_json = json_encode($questions);

   // Return JSON response to front-end
   echo $questions_json;
} else {
   echo "No survey questions found.";
}

// Close connection
$conn->close();
?>