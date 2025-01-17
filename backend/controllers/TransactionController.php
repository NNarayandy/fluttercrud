<?php
include_once '../../config/database.php';
include_once '../../models/Transaction.php';

class TransactionController {
    private $conn;
    private $transaction;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
        $this->transaction = new Transaction($this->conn);
    }

    public function getAllTransactions() {
        return $this->transaction->getAll();
    }

    public function getTransactionById($id) {
        return $this->transaction->getById($id);
    }

    public function createTransaction($itemId, $quantity, $type, $date) {
        return $this->transaction->create($itemId, $quantity, $type, $date);
    }

    public function updateTransaction($id, $itemId, $quantity, $type, $date) {
        return $this->transaction->update($id, $itemId, $quantity, $type, $date);
    }

    public function deleteTransaction($id) {
        return $this->transaction->delete($id);
    }
}
?>