<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/database.php';

$id = $_POST['id'];

$item = new Item($conn);

if ($item->delete($id)) {
    http_response_code(200);
    echo json_encode(array("success" => true, "message" => "Item deleted successfully."));
} else {
    http_response_code(503);
    echo json_encode(array("success" => false, "message" => "Unable to delete item."));
}
?>