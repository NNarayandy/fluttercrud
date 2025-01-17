<?php
include_once '../../config/database.php';
include_once '../../controllers/TransactionController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$transactionController = new TransactionController();

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->item_id) && !empty($data->quantity) && !empty($data->type) && !empty($data->date)) {
    $itemId = $data->item_id;
    $quantity = $data->quantity;
    $type = $data->type;
    $date = $data->date;

    if ($transactionController->createTransaction($itemId, $quantity, $type, $date)) {
        http_response_code(201);
        echo json_encode(array("message" => "Transaction created successfully."));
    } else {
        http_response_code(503);
        echo json_encode(array("message" => "Unable to create transaction."));
    }
} else {
    http_response_code(400);
    echo json_encode(array("message" => "Item ID, quantity, type, and date are required."));
}
?>