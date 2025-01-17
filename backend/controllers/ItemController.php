<?php
include_once '../../config/database.php';
include_once '../../models/Item.php';

class ItemController {
    private $conn;
    private $item;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
        $this->item = new Item($this->conn);
    }

    public function getAllItems() {
        return $this->item->getAll();
    }

    public function getItemById($id) {
        return $this->item->getById($id);
    }

    public function createItem($name, $description, $quantity, $warehouseId) {
        return $this->item->create($name, $description, $quantity, $warehouseId);
    }

    public function updateItem($id, $name, $description, $quantity, $warehouseId) {
        return $this->item->update($id, $name, $description, $quantity, $warehouseId);
    }

    public function deleteItem($id) {
        return $this->item->delete($id);
    }
}
?>