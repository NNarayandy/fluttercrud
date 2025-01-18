<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';


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