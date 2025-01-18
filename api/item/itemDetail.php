<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require_once $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Cek apakah parameter 'id' dikirim melalui URL
if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Missing required parameter: id"
    ]);
    exit();
}

$id = intval($_GET['id']);

// Query untuk mengambil detail item berdasarkan ID
$sql = "SELECT id, name, description, quantity, warehouse_id FROM item WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

// Periksa apakah data ditemukan
if ($result->num_rows > 0) {
    $item = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "data" => $item
    ]);
} else {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "Item not found"
    ]);
}

// Tutup koneksi
$stmt->close();
$conn->close();
?>
