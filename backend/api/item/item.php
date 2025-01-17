<?php
class Item {
    private $conn;

    public function __construct($conn) {
        $this->conn = $conn;
    }

    // ...

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

    // ...
}
?>