<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require_once $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Validasi input
if (!isset($_POST['id'])) {
    error_log('Missing parameter: id'); // Log error untuk debugging
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Missing required parameter: id"
    ]);
    exit();
}

$id = intval($_POST['id']);

// Query untuk mengambil detail item
$sql = "SELECT id, name, description, quantity, warehouse_id FROM item WHERE id = ?";
$stmt = $conn->prepare($sql);
if (!$stmt) {
    error_log('Failed to prepare statement: ' . $conn->error); // Log error jika statement gagal
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Server error while preparing statement"
    ]);
    exit();
}
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $item = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "data" => [
            "id" => $item["id"],
            "name" => $item["name"],
            "description" => $item["description"] ?? null,
            "quantity" => $item["quantity"],
            "warehouse_id" => $item["warehouse_id"]
        ]
    ]);
} else {
    error_log('Item not found with id: ' . $id); // Log jika item tidak ditemukan
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "Item not found"
    ]);
}

$stmt->close();
$conn->close();
?>
