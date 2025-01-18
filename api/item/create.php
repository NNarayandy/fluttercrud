<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

$name = $_POST['name'];
$description = $_POST['description'];
$quantity = $_POST['quantity'];
$warehouseId = $_POST['warehouse_id'];

$item = new Item($conn);

if ($item->create($name, $description, $quantity, $warehouseId)) {
    http_response_code(201);
    echo json_encode(array("success" => true, "message" => "Item created successfully."));
} else {
    http_response_code(503);
    echo json_encode(array("success" => false, "message" => "Unable to create item."));
}
?>