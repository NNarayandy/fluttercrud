<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

$data = json_decode(file_get_contents("php://input")); // Ambil data JSON dari request

// Validasi data input
if (!empty($data->name) && !empty($data->location)) {
    $name = $conn->real_escape_string($data->name); // Hindari SQL Injection
    $location = $conn->real_escape_string($data->location);

    // Query SQL untuk menambahkan data warehouse
    $sql = "INSERT INTO warehouse (name, location) VALUES ('$name', '$location')";

    if ($conn->query($sql)) {
        http_response_code(201); // Status: Created
        echo json_encode(array("message" => "Warehouse created successfully."));
    } else {
        http_response_code(503); // Status: Service Unavailable
        echo json_encode(array("message" => "Unable to create warehouse."));
    }
} else {
    http_response_code(400); // Status: Bad Request
    echo json_encode(array("message" => "Name and location are required."));
}
?>
