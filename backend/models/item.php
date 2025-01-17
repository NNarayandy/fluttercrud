<?php
class Item {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAll() {
        $query = "SELECT * FROM item";
        $result = $this->conn->query($query);
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function getById($id) {
        $query = "SELECT * FROM item WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    public function create($name, $description, $quantity, $warehouseId) {
        $query = "INSERT INTO item (name, description, quantity, warehouse_id) VALUES (?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssii", $name, $description, $quantity, $warehouseId);
        return $stmt->execute();
    }

    public function update($id, $name, $description, $quantity, $warehouseId) {
        $query = "UPDATE item SET name = ?, description = ?, quantity = ?, warehouse_id = ? WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssiii", $name, $description, $quantity, $warehouseId, $id);
        return $stmt->execute();
    }

    public function delete($id) {
        $query = "DELETE FROM item WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
}
?>