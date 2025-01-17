<?php
include_once '../../config/database.php';
include_once '../../controllers/WarehouseController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$warehouseController = new WarehouseController();

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->name) && !empty($data->location)) {
    $name = $data->name;
    $location = $data->location;

    if ($warehouseController->createWarehouse($name, $location)) {
        http_response_code(201);
        echo json_encode(array("message" => "Warehouse created successfully."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create warehouse."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Name and location are required."));
}
?>