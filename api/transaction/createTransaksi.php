<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

$data = json_decode(file_get_contents("php://input"));

if (isset($data->item_id, $data->quantity, $data->type)) {
    $itemId = intval($data->item_id);
    $quantity = intval($data->quantity);
    $type = $conn->real_escape_string($data->type);
    $date = !empty($data->date) ? $conn->real_escape_string($data->date) : null;

    $sql = $date ?
        "INSERT INTO transaction (item_id, quantity, type, date) VALUES (?, ?, ?, ?)" :
        "INSERT INTO transaction (item_id, quantity, type) VALUES (?, ?, ?)";

    $stmt = $conn->prepare($sql);

    if ($date) {
        $stmt->bind_param("iiss", $itemId, $quantity, $type, $date);
    } else {
        $stmt->bind_param("iis", $itemId, $quantity, $type);
    }

    if ($stmt->execute()) {
        http_response_code(201);
        echo json_encode(["success" => true, "message" => "Transaction created successfully."]);
    } else {
        http_response_code(503);
        echo json_encode(["success" => false, "message" => "Unable to create transaction."]);
    }

    $stmt->close();
} else {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Item ID, quantity, and type are required."
    ]);
}

$conn->close();
?>
