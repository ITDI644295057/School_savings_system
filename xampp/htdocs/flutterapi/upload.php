<?php
header('Content-Type: application/json');

$targetDir = "images/";
$response = array();

if (isset($_FILES["image"]["name"])) {
    // Get the file name and target file path
    $fileName = basename($_FILES["image"]["name"]);
    $targetFilePath = $targetDir . $fileName;

    // Check if the directory exists, if not create it
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    // Upload file to the server
    if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFilePath)) {
        // File successfully uploaded
        $response['status'] = 'success';
        $response['message'] = 'File uploaded successfully';
        $response['filePath'] = $targetFilePath;
    } else {
        // File upload failed
        $response['status'] = 'error';
        $response['message'] = 'File upload failed, please try again.';
    }
} else {
    // No file was uploaded
    $response['status'] = 'error';
    $response['message'] = 'No file was uploaded.';
}

// Return the response as JSON
echo json_encode($response);
?>
