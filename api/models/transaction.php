<?php
class Transaction {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAll() {
        $query = "SELECT * FROM transaction";
        $result = $this->conn->query($query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function getById($id) {
        $query = "SELECT * FROM transaction WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    public function create($itemId, $quantity, $type, $date) {
        $query = "INSERT INTO transaction (item_id, quantity, type, date) VALUES (?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("iiss", $itemId, $quantity, $type, $date);
        return $stmt->execute();
    }

    public function update($id, $itemId, $quantity, $type, $date) {
        $query = "UPDATE transaction SET item_id = ?, quantity = ?, type = ?, date = ? WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("iissi", $itemId, $quantity, $type, $date, $id);
        return $stmt->execute();
    }

    public function delete($id) {
        $query = "DELETE FROM transaction WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}
?>