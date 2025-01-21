<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Mendapatkan data JSON dari request
$data = json_decode(file_get_contents("php://input"), true);

// Validasi ID
// Validasi data yang diterima
if (!isset($data['id'])) {
    echo json_encode(['success' => false, 'message' => 'ID is required.']);
    exit();
}


// Menyimpan data ke dalam variabel
$id = $conn->real_escape_string($data['id']);
$updates = [];

// Menambahkan field untuk diupdate jika ada di input
if (!empty($data['name'])) {
    $name = $conn->real_escape_string($data['name']);
    $updates[] = "name = '$name'";
}

if (isset($data['description'])) { // Bisa kosong, jadi gunakan isset
    $description = $data['description'] !== null 
        ? "'" . $conn->real_escape_string($data['description']) . "'" 
        : "NULL";
    $updates[] = "description = $description";
}

if (!empty($data['quantity'])) {
    $quantity = $conn->real_escape_string($data['quantity']);
    $updates[] = "quantity = '$quantity'";
}

if (!empty($data['warehouse_id'])) {
    $warehouse_id = $conn->real_escape_string($data['warehouse_id']);
    $updates[] = "warehouse_id = '$warehouse_id'";
}

// Jika tidak ada field yang diperbarui, kirimkan respon gagal
if (empty($updates)) {
    echo json_encode(['success' => false, 'message' => 'No fields to update.']);
    exit();
}

// Membuat query update
$query = "UPDATE item SET " . implode(', ', $updates) . " WHERE id = '$id'";

// Eksekusi query
if ($conn->query($query) === TRUE) {
    echo json_encode(['success' => true, 'message' => 'Item updated successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Error updating item: ' . $conn->error]);
}

// Tutup koneksi
$conn->close();
?>
