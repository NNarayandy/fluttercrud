<?php
// Headers untuk CORS dan JSON
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Sambungkan database
include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

// Inisialisasi respons
$response = [
    'success' => false,
    'message' => ''
];

try {
    // Validasi input
    if (!isset($_POST['name']) || 
        !isset($_POST['description']) || 
        !isset($_POST['quantity']) || 
        !isset($_POST['warehouse_id'])) {
        throw new Exception("Missing required parameters");
    }

    // Ambil data dari POST
    $name = trim($_POST['name']);
    $description = trim($_POST['description']);
    $quantity = intval($_POST['quantity']);
    $warehouseId = intval($_POST['warehouse_id']);

    // Validasi data
    if (empty($name)) {
        throw new Exception("Name cannot be empty");
    }

    // Query untuk membuat item baru
    $query = "INSERT INTO item (name, description, quantity, warehouse_id) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);

    if ($stmt) {
        // Mengikat parameter untuk query
        $stmt->bind_param("ssii", $name, $description, $quantity, $warehouseId);

        // Menjalankan query
        if ($stmt->execute()) {
            http_response_code(201); // Status sukses
            $response['success'] = true;
            $response['message'] = "Item created successfully.";
            $response['data'] = [
                'name' => $name,
                'description' => $description,
                'quantity' => $quantity,
                'warehouse_id' => $warehouseId
            ];
        } else {
            throw new Exception("Failed to execute query");
        }

        // Menutup statement
        $stmt->close();
    } else {
        throw new Exception("Failed to prepare query");
    }

    // Menutup koneksi
    $conn->close();
} catch (Exception $e) {
    // Jika terjadi error
    http_response_code(400); // Bad Request
    $response['message'] = $e->getMessage();
}

// Keluarkan respons JSON
echo json_encode($response);
?>
