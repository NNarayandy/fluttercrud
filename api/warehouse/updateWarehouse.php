<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Konfigurasi database
include_once $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/config/database.php';

// Memeriksa apakah data ada di request
if (isset($_POST['id']) && isset($_POST['name']) && isset($_POST['location'])) {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $location = $_POST['location'];

    // Menyiapkan query SQL untuk memperbarui data warehouse
    $sql = "UPDATE warehouse SET name = ?, location = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssi", $name, $location, $id); // Mengikat parameter: string untuk name dan location, integer untuk id

    // Mengeksekusi query
    if ($stmt->execute()) {
        // Jika update berhasil
        echo json_encode(["message" => "Warehouse updated successfully"]);
    } else {
        // Jika update gagal
        echo json_encode(["message" => "Failed to update warehouse"]);
    }

    // Menutup statement
    $stmt->close();
} else {
    // Jika parameter tidak ada
    echo json_encode(["message" => "Required parameters are missing"]);
}

// Menutup koneksi
$conn->close();
?>
