<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

$sql = "SELECT id, name, location FROM warehouse";
$result = $conn->query($sql);

$warehouses = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $warehouses[] = $row;
    }
}

if (!empty($warehouses)) {
    echo json_encode([
        "success" => true,
        "data" => $warehouses
    ]);
} else {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "No warehouses found."
    ]);
}

$conn->close();
?>
