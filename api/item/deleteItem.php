<?php
// Mengatur header agar API selalu bisa diakses dari luar
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Max-Age: 3600');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

// Menghubungkan ke database
include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Inisialisasi variabel respons
$response = [
    'success' => false,
    'message' => ''
];

try {
    // Memeriksa apakah parameter 'id' ada dan valid
    if (!isset($_POST['id']) || !is_numeric($_POST['id'])) {
        throw new Exception("ID parameter is missing or invalid");
    }

    // Mendapatkan id item dari request
    $id = intval($_POST['id']);

    // Query untuk menghapus item berdasarkan id
    $query = "DELETE FROM item WHERE id = ?";

    // Menyiapkan statement
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Failed to prepare query: " . $conn->error);
    }

    // Mengikat parameter
    $stmt->bind_param("i", $id);

    // Menjalankan query
    if (!$stmt->execute()) {
        throw new Exception("Failed to delete item: " . $stmt->error);
    }

    // Memeriksa apakah ada baris yang benar-benar dihapus
    if ($stmt->affected_rows == 0) {
        throw new Exception("No item found with the given ID");
    }

    // Jika berhasil
    $response['success'] = true;
    $response['message'] = "Item deleted successfully";

} catch (Exception $e) {
    // Tangkap semua kesalahan
    $response['message'] = $e->getMessage();

} finally {
    // Pastikan statement ditutup
    if (isset($stmt) && $stmt instanceof mysqli_stmt) {
        $stmt->close();
    }

    // Tutup koneksi database
    if (isset($conn)) {
        $conn->close();
    }

    // Keluarkan respons JSON
    echo json_encode($response);
}
?>