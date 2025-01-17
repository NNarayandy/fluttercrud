<?php
include_once '../../config/database.php';
include_once '../../controllers/WarehouseController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$warehouseController = new WarehouseController();

$warehouses = $warehouseController->getAllWarehouses();

if (!empty($warehouses)) {
    $response = array(
        "data" => $warehouses
    );
    http_response_code(200);
    echo json_encode($response);
} else {
    $response = array(
        "message" => "No warehouses found."
    );
    http_response_code(404);
    echo json_encode($response);
}
?>