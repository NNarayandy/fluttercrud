<?php
include_once '../../config/database.php';
include_once '../../WarehouseController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$warehouseController = new WarehouseController();

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id) && !empty($data->name) && !empty($data->location)) {
    $id = $data->id;
    $name = $data->name;
    $location = $data->location;

    if ($warehouseController->updateWarehouse($id, $name, $location)) {
        http_response_code(200);
        echo json_encode(array("message" => "Warehouse updated successfully."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to update warehouse."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "ID, name, and location are required."));
}
?>