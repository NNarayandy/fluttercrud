<?php
include_once '../../config/database.php';
include_once '../../controllers/TransactionController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$transactionController = new TransactionController();

$transactions = $transactionController->getAllTransactions();

if (!empty($transactions)) {
    $response = array(
        "data" => $transactions
    );
    http_response_code(200);
    echo json_encode($response);
} else {
    $response = array(
        "message" => "No transactions found."
    );
    http_response_code(404);
    echo json_encode($response);
}
?>