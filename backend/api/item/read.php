<?php
include_once '../../config/database.php';
include_once '../../controllers/ItemController.php';

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$itemController = new ItemController();

if (isset($_GET['id'])) {
    $itemId = $_GET['id'];
    $item = $itemController->getItemById($itemId);

    if (!empty($item)) {
        $response = array(
            "data" => $item
        );
        http_response_code(200);
        echo json_encode($response);
    } else {
        $response = array(
            "message" => "Item not found."
        );
        http_response_code(404);
        echo json_encode($response);
    }
} else {
    $items = $itemController->getAllItems();

    if (!empty($items)) {
        $response = array(
            "data" => $items
        );
        http_response_code(200);
        echo json_encode($response);
    } else {
        $response = array(
            "message" => "No items found."
        );
        http_response_code(404);
        echo json_encode($response);
    }
}
?>