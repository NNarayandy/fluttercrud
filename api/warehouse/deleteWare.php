<?php
// Set headers untuk CORS
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, DELETE, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Sertakan koneksi database
include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Tangani OPTIONS (CORS Preflight)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Ambil metode request
$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'DELETE' || $method === 'POST') {
    // Ambil data dari request body
    $data = json_decode(file_get_contents("php://input"));

    // Periksa apakah ID tersedia
    if (!empty($data->id)) {
        $id = intval($data->id); // Pastikan ID adalah integer

        // Siapkan query SQL untuk delete
        $sql = "DELETE FROM warehouse WHERE id = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id);

        // Eksekusi query
        if ($stmt->execute()) {
            http_response_code(200);
            echo json_encode(array("success" => true, "message" => "Warehouse deleted successfully."));
        } else {
            http_response_code(503);
            echo json_encode(array("success" => false, "message" => "Unable to delete warehouse."));
        }
        $stmt->close();
    } else {
        // Jika ID kosong
        http_response_code(400);
        echo json_encode(array("success" => false, "message" => "Warehouse ID is required."));
    }
} else {
    // Metode selain DELETE/POST
    http_response_code(405);
    echo json_encode(array("success" => false, "message" => "Method not allowed."));
}

// Tutup koneksi database
$conn->close();
?>
