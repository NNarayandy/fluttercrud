<?php
include_once '../../config/database.php';
include_once '../../models/Item.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$id = $_POST['id'];
$name = $_POST['name'];
$description = $_POST['description'];
$quantity = $_POST['quantity'];
$warehouseId = $_POST['warehouse_id'];

$item = new Item($conn);

if ($item->update($id, $name, $description, $quantity, $warehouseId)) {
    http_response_code(200);
    echo json_encode(array("success" => true, "message" => "Item updated successfully."));
} else {
    http_response_code(503);
    echo json_encode(array("success" => false, "message" => "Unable to update item."));
}
?>