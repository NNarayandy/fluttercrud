<?php
// Mengatur header agar API dapat diakses dari aplikasi Anda
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Mendapatkan data JSON dari request
$data = json_decode(file_get_contents("php://input"), true);

// Validasi data yang diterima
if (!isset($data['id']) || !isset($data['name']) || !isset($data['quantity']) || !isset($data['warehouse_id'])) {
    echo json_encode(['success' => false, 'message' => 'Incomplete data provided.']);
    exit;
}

// Menyimpan data ke dalam variabel
$id = $conn->real_escape_string($data['id']);
$name = $conn->real_escape_string($data['name']);
$description = isset($data['description']) ? $conn->real_escape_string($data['description']) : null;
$quantity = $conn->real_escape_string($data['quantity']);
$warehouse_id = $conn->real_escape_string($data['warehouse_id']);

// Query untuk update data
$query = "UPDATE item 
          SET name = '$name', 
              description = " . ($description ? "'$description'" : "NULL") . ", 
              quantity = '$quantity', 
              warehouse_id = '$warehouse_id' 
          WHERE id = '$id'";

if ($conn->query($query) === TRUE) {
    echo json_encode(['success' => true, 'message' => 'Item updated successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Error updating item: ' . $conn->error]);
}

// Menutup koneksi
$conn->close();
?>
