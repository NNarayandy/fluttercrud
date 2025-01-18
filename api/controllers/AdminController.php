<?php
require_once $_SERVER['DOCUMENT_ROOT'].'/gudangdb/api/models/Admin.php';

class AdminController {
    private $conn;
    private $admin;

    public function __construct() {
        global $conn;
        $this->conn = $conn;
        $this->admin = new Admin($this->conn);
    }

    public function login($username, $password) {
        return $this->admin->authenticate($username, $password);
    }
}
?>