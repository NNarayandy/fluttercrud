<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

// Query untuk membaca data transaksi
$sql = "SELECT id, item_id, quantity, type, date FROM transaction";
$result = $conn->query($sql);

$transactions = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $transactions[] = $row;
    }
}

if (!empty($transactions)) {
    echo json_encode([
        "success" => true,
        "data" => $transactions
    ]);
} else {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "No transactions found."
    ]);
}

$conn->close();
?>
