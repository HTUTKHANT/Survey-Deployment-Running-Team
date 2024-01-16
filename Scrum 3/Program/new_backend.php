<?php

// Function to handle survey answers and determine the next question
function submitSurveyAnswers() {
    // Retrieve JSON data from the request
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);

    // Process survey answers
    $answers = $data['answers'];
    $currentQuestionID = $data['currentQuestionID'];

    // Save answers to the database (implement this based on database logic)
    saveAnswersToDatabase($answers, $currentQuestionID);

    // Determine the next question ID based on rules
    $nextQuestionID = getNextQuestionID($currentQuestionID, $answers);

    // Return the next question ID to the frontend
    $response = ['nextQuestionID' => $nextQuestionID];
    echo json_encode($response);
}

// Function to save answers to the database
function saveAnswersToDatabase($answers, $questionID) {
    // Assuming you have a database connection, replace the placeholder values with your actual database details
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

    // Assuming 'Answer_ID' is auto-incremented
    $questionID = (int) $questionID;

    // Insert answers into the 'answer' table
    $sql = "INSERT INTO answer (Question_ID, Answer_Choice, Answer_StartDate, Answer_EndDate, Answer_StartTime, Answer_EndTime)
            VALUES ($questionID, '" . $answers['question1'] . "', NOW(), NOW(), NOW(), NOW())";

    if ($conn->query($sql) === TRUE) {
        echo "Answers saved to the database successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close connection
    $conn->close();
}

// Function to get the next question ID based on rules
function getNextQuestionID($currentQuestionID, $answers) {
    // Implement logic to fetch the next question ID from the database based on rules
    // Use the $answers array to check conditions and retrieve the appropriate next question ID
    // Can use the 'survey_question_rule' table for this purpose

    // Example logic (replace with your actual rules)
    if ($currentQuestionID == 1) {
        // If the answer to Question 1 is 'Yes', go to Question 2; otherwise, go to Question 3
        return ($answers['question1'] == 'Yes') ? 2 : 3;
    }

    // Default case: No more questions
    return 0;
}

// Call the function to handle survey answers
submitSurveyAnswers();
?>
