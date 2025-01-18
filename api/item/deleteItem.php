<?php

// Mengatur header agar API selalu bisa diakses dari luar
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Max-Age: 3600');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

// Menghubungkan ke database
include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Memeriksa apakah parameter 'id' ada
if (isset($_POST['id'])) {
    // Mendapatkan id item dari request
    $id = $_POST['id'];

    // Query untuk menghapus item berdasarkan id
    $query = "DELETE FROM items WHERE id = ?";

    // Menyiapkan query
    if ($stmt = $conn->prepare($query)) {
        // Mengikat parameter untuk query
        $stmt->bind_param("i", $id);

        // Menjalankan query
        if ($stmt->execute()) {
            // Jika berhasil, kembalikan respons sukses
            echo json_encode(["success" => true, "message" => "Item deleted successfully"]);
        } else {
            // Jika gagal, kembalikan pesan error
            echo json_encode(["success" => false, "message" => "Failed to delete item"]);
        }

        // Menutup statement
        $stmt->close();
    } else {
        // Jika query gagal dipersiapkan
        echo json_encode(["success" => false, "message" => "Failed to prepare query"]);
    }

    // Menutup koneksi
    $conn->close();
} else {
    // Jika 'id' tidak ada pada request
    echo json_encode(["success" => false, "message" => "ID parameter missing"]);
}
?>
