<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

include_once $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize input
    $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
    $item_id = isset($_POST['item_id']) ? intval($_POST['item_id']) : 0;
    $quantity = isset($_POST['quantity']) ? intval($_POST['quantity']) : 0;
    $type = isset($_POST['type']) ? trim($_POST['type']) : '';
    $date = isset($_POST['date']) ? trim($_POST['date']) : '';

    // Validate required fields
    if ($id <= 0 || $item_id <= 0 || empty($type) || empty($date)) {
        $response['success'] = false;
        $response['message'] = 'Invalid input. Please provide all required fields.';
        echo json_encode($response);
        exit;
    }

    // Update query
    $query = "UPDATE transaction SET item_id = ?, quantity = ?, type = ?, date = ? WHERE id = ?";

    if ($stmt = $conn->prepare($query)) {
        $stmt->bind_param('iissi', $item_id, $quantity, $type, $date, $id);

        if ($stmt->execute()) {
            if ($stmt->affected_rows > 0) {
                $response['success'] = true;
                $response['message'] = 'Transaction updated successfully.';
            } else {
                $response['success'] = false;
                $response['message'] = 'No changes made or transaction not found.';
            }
        } else {
            $response['success'] = false;
            $response['message'] = 'Failed to update transaction. Error: ' . $stmt->error;
        }

        $stmt->close();
    } else {
        $response['success'] = false;
        $response['message'] = 'Failed to prepare statement. Error: ' . $conn->error;
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid request method. Please use POST.';
}

$conn->close();
echo json_encode($response);
