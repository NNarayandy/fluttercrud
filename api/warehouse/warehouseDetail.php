<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Memeriksa apakah parameter 'id' ada
if (isset($_GET['id'])) {
    $id = $_GET['id'];

    // Menyiapkan query SQL untuk mengambil data warehouse berdasarkan ID
    $sql = "SELECT id, name, location FROM warehouse WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $id); // Mengikat parameter ID sebagai integer
    $stmt->execute();

    // Menyimpan hasil query
    $result = $stmt->get_result();

    // Memeriksa apakah data ditemukan
    if ($result->num_rows > 0) {
        // Mengambil data warehouse
        $warehouse = $result->fetch_assoc();

        // Mengembalikan data sebagai JSON
        echo json_encode($warehouse);
    } else {
        // Jika data tidak ditemukan
        echo json_encode(["message" => "Warehouse not found"]);
    }

    // Menutup koneksi
    $stmt->close();
} else {
    // Jika parameter 'id' tidak ada
    echo json_encode(["message" => "ID is required"]);
}

$conn->close();
?>
