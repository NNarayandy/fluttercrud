<?php
include_once '../../config/database.php';
include_once '../../models/Warehouse.php';

class WarehouseController {
    private $conn;
    private $warehouse;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
        $this->warehouse = new Warehouse($this->conn);
    }

    public function getAllWarehouses() {
        return $this->warehouse->getAll();
    }

    public function getWarehouseById($id) {
        return $this->warehouse->getById($id);
    }

    public function createWarehouse($name, $location) {
        return $this->warehouse->create($name, $location);
    }

    public function updateWarehouse($id, $name, $location) {
        return $this->warehouse->update($id, $name, $location);
    }

    public function deleteWarehouse($id) {
        return $this->warehouse->delete($id);
    }
}
?>