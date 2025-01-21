<?php
// Set headers untuk mendukung CORS
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Sertakan koneksi database
include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Tangani preflight request (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Pastikan hanya menerima request POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari request body
    $data = json_decode(file_get_contents("php://input"));

    // Validasi input
    if (!empty($data->name) && !empty($data->location)) {
        // Hindari SQL Injection dengan prepared statement
        $sql = "INSERT INTO warehouse (name, location) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $data->name, $data->location);

        // Eksekusi query
        if ($stmt->execute()) {
            http_response_code(201); // Status: Created
            echo json_encode(array("success" => true, "message" => "Warehouse created successfully."));
        } else {
            http_response_code(503); // Status: Service Unavailable
            echo json_encode(array("success" => false, "message" => "Unable to create warehouse."));
        }
        $stmt->close();
    } else {
        // Jika data input tidak valid
        http_response_code(400); // Status: Bad Request
        echo json_encode(array("success" => false, "message" => "Name and location are required."));
    }
} else {
    // Jika metode tidak valid
    http_response_code(405); // Status: Method Not Allowed
    echo json_encode(array("success" => false, "message" => "Method not allowed."));
}

// Tutup koneksi database
$conn->close();
?>
