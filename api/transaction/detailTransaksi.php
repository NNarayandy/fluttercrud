<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

include $_SERVER['DOCUMENT_ROOT'] . '/gudangdb/api/database.php';

$response = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Mendapatkan data dari body request
    $transactionId = isset($_POST['id']) ? intval($_POST['id']) : 0;

    if ($transactionId > 0) {
        // Query untuk mengambil detail transaksi
        $query = "SELECT * FROM transaction WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $transactionId);

        if ($stmt->execute()) {
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $transaction = $result->fetch_assoc();

                $response['success'] = true;
                $response['data'] = [
                    'id' => $transaction['id'],
                    'item_id' => $transaction['item_id'],
                    'quantity' => $transaction['quantity'],
                    'type' => $transaction['type'],
                    'date' => $transaction['date']
                ];
            } else {
                $response['success'] = false;
                $response['message'] = 'Transaction not found';
            }
        } else {
            $response['success'] = false;
            $response['message'] = 'Failed to execute query';
        }

        $stmt->close();
    } else {
        $response['success'] = false;
        $response['message'] = 'Invalid transaction ID';
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid request method';
}

echo json_encode($response);

$conn->close();
