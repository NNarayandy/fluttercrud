<?php

// Headers untuk CORS dan JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Query untuk mengambil semua data item
$sql = "SELECT id, name, description, quantity, warehouse_id FROM item";
$result = $conn->query($sql);

// Menyiapkan array untuk menyimpan data
$items = array();

if ($result->num_rows > 0) {
    // Mengambil data setiap baris
    while($row = $result->fetch_assoc()) {
        $item = array(
            "id" => $row["id"],
            "name" => $row["name"],
            "description" => $row["description"],
            "quantity" => $row["quantity"],
            "warehouse_id" => $row["warehouse_id"]
        );
        array_push($items, $item);
    }
}

// Kirim respons JSON (kosong jika tidak ada data)
echo json_encode($items);

// Menutup koneksi
$conn->close();
?>
